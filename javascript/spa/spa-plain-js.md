# SPA using plain javascript

## html
```html

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<title>SPA Form with plain javascript</title>
	</head>
	<body class="bg-black">
		<div id="spa-page-container">
			<div id="header">
        <ul>
          <li>Home</li>
          <li onclick="switchRoute('about')">About</li>
          <li onclick="switchRoute('contact')">Contact</li>
      </div>

							<!-- Content Start Here -->
<div id="main-container" style="background-color: rgba(135, 235, 198, 0);" class="section">

		<div id="homeContainer" class="flex-row-center" style="display: none;" >
			Home
		</div>

		<div id="aboutContainer" class="flex-row-center" style="display: none;" >
			About
		</div>

		<div id="contactContainer" class="flex-row-center" style="display: none;" >
			Contact Info.
		</div>

		<div id="dataGridloadingIndicator" class="flex-row-center" style="display: none;" >
			<img src="/images/spin.gif" alt="loading indicator" />
		</div>

		<div id="errorMessageContainer" class="flex-row-center" style="display: none;" >
			<div class="error">
				<span>Custom Error</span>
				<div><a class="smallbutton aoda-button" onclick="searchAgain()" aria-label="Try again">Try again</a></div>
			</div>
		</div>

		<div id="unavailableContainer" class="flex-row-center" style="display: none;width: 911px; height: 640px;padding: 25px;margin: auto;" >
			<div>
				<h1 class="heading">Temporarily unavailable for system maintenance.</h1>
			</div>
		</div>

		<div id="resultContainer" class="" style="display: none;">
		</div>

</div>
						<!-- Content Ends Here -->
	</body>
</html>
```

```js

const { forkJoin } = rxjs;
const pageState = {
  standby: 'standby',
  inProgress: 'inProgress',
  completed: 'completed',
  showAbout: 'showAbout',
  showContact: 'showContact',
  error: 'error',
  unavailable: 'unavailable',
};

let homeContainer = document.getElementById('homeContainer');
let aboutContainer = document.getElementById('aboutContainer');
let contactContainer = document.getElementById('contactContainer');

const { BehaviorSubject } = rxjs;
const stateManagerBS$ = new BehaviorSubject(pageState.standby);

const displayHome = () => {
  homeContainer.style.display = 'block';
  aboutContainer.style.display = 'none';
  contactContainer.style.display = 'none';
}

const showAbout = () => {
  homeContainer.style.display = 'none';
  aboutContainer.style.display = 'block';
  contactContainer.style.display = 'none';
}

const handleRouting = async () => {
  const routeHash = window.location.hash;
  switch (routeHash) {
    case "#about":
      stateManagerBS$.next(pageState.showTermsAndConditions);
      break;
    case "#contact":
      stateManagerBS$.next(pageState.completed);
      break;
    default:
      stateManagerBS$.next(pageState.standby);
      break;
  }
};

const onStateChanged = (state) => {
  switch (state) {
    case pageState.standby:
      displayHome();
      break;
    case pageState.inProgress:
      dataLoading();
      break;
    case pageState.showAbout:
      showAbout();
      break;
    case pageState.showContact:
      showContact();
      break;
    case pageState.completed:
      dataLoadingCompleted();
      break;
    case pageState.error:
      showErrorMessage();
      break;
    case pageState.unavailable:
      showUnavailable();
      break;
    default:
      break;
  }
}

let switchRoute = (routeId) => {
  switch (routeId) {
    case 'about':
      stateManagerBS$.next(pageState.showAbout);
      break;
    case 'contact':
      stateManagerBS$.next(pageState.showContact);
      break;
    default:
      stateManagerBS$.next(pageState.standby);
  }
}

let init = () => {
  stateManagerBS$.subscribe({
    next: onStateChanged,
    error: (e) => console.error(e),
    complete: () => console.info('stateManagerBS$ complete')
  });

  window.onpopstate = handleRouting;
  handleRouting();
}

// Initial setup for the page
init();
```