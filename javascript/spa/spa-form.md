```html
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<title>SPA Form with rxjs</title>
		<link rel="stylesheet" type="text/css" href="/css/pub_style.css?v=3.333">
	</head>
	<body class="bg-black">
		<div id="secure-page-container">
			<div id="secure-content-row">
				<div id="secure-main-content-container" style="width:970px">
						<div id="secure-content">

							<!-- Content Start Here -->
<div id="main-container" style="background-color: rgba(135, 235, 198, 0);" class="section">
	<div id="tab-container">
	</div>
	<div id="subTitle" class="section"><span class="whitenewsbold">Form template</span></div>
	<div id="description" class="section whitenewsbold">
	</div>
	<div id="subTitle" class="section"><span class="">Search by at least one option below:</span></div>
	<FORM id="search" name="search" >
		<input type="hidden" name="modulePageName" value="uniAvCuesPage"/>
		<input type="hidden" name="subPage" value="uniAvStartSearch" />
		<input type="hidden" name="request" value="" />
		<input type="hidden" name="currentPage" value="1">
		<input type="hidden" name="recordPerPage" value="100">

		<fieldset id="workCueSearchOptionContainer" class="txt-cf search_group_small">
			<legend class="txt-cf search_legend"><label for="productionTitle">Production title</label></legend>
			<div class="txt-cf search_group_small" style="display: grid; grid-template-columns: repeat(3, 20px 45px);">
				<input id="categoryFilm" name="category" type="radio" value="Film" checked="checked" aria-label="Film">
				<label for="categoryFilm" class="form-label-Right">Film</label>
				<input id="categorySeries" name="category" type="radio" value="Series" aria-label="Category">
				<label for="categorySeries" class="form-label-Right">Series</label>
				<input id="categoryEpisode" name="category" type="radio" value="IPI" aria-label="Episode">
				<label for="categoryEpisode" class="form-label-Right">Episode</label>
			</div>
			<div class="txt-cf" style="display: grid; grid-template-columns: 150px 400px;">
				<select id="workCueSearchOption" name="workCueSearchOption" style="height: fit-content;" class="search_select" aria-label="Search For">
					<option value="b" >Begins with</option>
					<option value="c" >Contains</option>
					<option value="e" >Exact match</option>
				</select>
					<div>
						<input type="text" id="productionTitle" name="productionTitle" size="50" maxlength="50" value="" aria-label="work Number" >
					</div>
			</div>
		</fieldset>

		<fieldset id="cueTitleContainer" class="txt-cf search_group_small">
			<legend class="txt-cf search_legend"><label for="cueTitle">Title</label></legend>
			<div class="txt-cf" style="display: grid; grid-template-columns: 150px 400px;">
				<select id="workCueSearchOption" name="workCueSearchOption" style="height: fit-content;" class="search_select" aria-label="Search For">
					<option value="b" >Begins with</option>
					<option value="c" >Contains</option>
					<option value="e" >Exact match</option>
				</select>
					<div>
						<input type="text" id="cueTitle" name="c" size="50" maxlength="50" value="" aria-label="Production Title" >
					</div>
			</div>
		</fieldset>

		<fieldset id="orTitleContainer" class="txt-cf search_group_small">
			<legend class="txt-cf search_legend"><label for="cueTitle"></label></legend>
			<div class="txt-cf" style="display: grid; grid-template-columns: 150px 400px;">
			OR
			</div>
		</fieldset>

		<fieldset id="audioVisualCueIdentifierContainer" class="txt-cf search_group_small">
			<legend class="txt-cf search_legend"><label ></label></legend>
			<div class="txt-cf" style="display: grid; grid-template-columns: 150px 400px;">
					<div>
						<label for="cueIdentifier">Cue Identifier</label>
					</div>
					<div>
						<input type="text" id="cueIdentifier" name="cueIdentifier" size="50" maxlength="50" value="" aria-label="Audio Visual Cue Identifier" >
					</div>
			</div>
		</fieldset>

		<fieldset id="searchControl" class="search_group_small" >
			<legend class="txt-cf search_legend"><label for="apiSubmit"></label></legend>
			<input id="submitBtn" type="button" value="Submit" class="button action-button" onClick="getData()" aria-label="submit button">
			<input id="ClearBtn" type="button" value="Clear" class="button action-button" onClick="clearFormAndSubmit();" aria-label="clear button">
			<a href="/jsp/en/mem/viewUniList.jsp" aria-label="submit button"><input id="backBtn" type="button" value="Back" class="button action-button" aria-label="back button"></a>
		</fieldset>

		<div id="dataGridloadingIndicator" class="flex-row-center" style="display: none;" >
			<img src="/images/spin.gif" alt="loading indicator" />
		</div>

		<div id="errorMessageContainer" class="flex-row-center" style="display: none;" >
			<div class="error">
				<span>Your search request was not successful. Please try again.</span>
				<div><a class="smallbutton aoda-button" onclick="searchAgain()" aria-label="Try again">Try again</a></div>
			</div>
		</div>

		<div id="unavailableContainer" class="flex-row-center" style="display: none;width: 911px; height: 640px;padding: 25px;margin: auto;" >
			<div>
				<h1 class="heading">Temporarily unavailable for system maintenance.</h1>
			</div>
		</div>

		<div id="resultContainer" class="" style="display: none;">
			<div id="submittedUniTabletViewContainer" ></div>
		</div>


</form>
</div>
						<!-- Content Ends Here -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
```

```js

const GeneralService = {
  constant: {
    state: {
      standby: 'standby',
      inProgress: 'inProgress',
      completed: 'completed',
      showTermsAndConditions: 'showTermsAndConditions',
      iAgreeTermsAndConditions: 'iAgreeTermsAndConditions',
      error: 'error',
      unavailable: 'unavailable',
    },
    mappings: {
    }
  },
  mappings: {
    getDescriptionByCode: (mappingObj, mappingCode) => {
      if(GeneralService.object.isEmpty(mappingObj) || GeneralService.object.isEmpty(mappingCode)) return '';
      return (mappingObj[mappingCode])?mappingObj[mappingCode].description[pageLanguage]:'';
    },
  },
  dateTime: {
    getDateParts: (dateTimeString) => {
      let intlDate = new Intl.DateTimeFormat("en-CA", {month:'2-digit',day:'2-digit', year:'numeric'}).formatToParts(new Date(dateTimeString));
      let dateObj = intlDate
				.filter( part => ~[`year`, `month`, `day`].indexOf(part.type) )
      	.reduce( (acc, curr) => ({...acc, [curr.type]: curr.value}), {} );
      return dateObj;
    },
    format: {
      default: (dateTimeString) => {
        let dateObj = GeneralService.DateTime.getDateParts(dateTimeString);
        return `${dateObj.month}-${dateObj.day}-${dateObj.year}`;
      },
      YYYY_MM_DD: (dateTimeString) => {
        let dateObj = GeneralService.dateTime.getDateParts(dateTimeString);
        return `${dateObj.year}-${dateObj.month}-${dateObj.day}`;
      }
    }
  },
  string: {
    removeDuplicates: (inStr, separator) => {
      let strAry = inStr.split(separator);
      let noDuplicateAry = new Set(strAry);
      return Array.from(noDuplicateAry).join(separator);
    }
  },
  object: {
    isEmpty: (inputObject) => {
      if (inputObject === null || inputObject === undefined) {
        return true;
      }
      // Check of empty string
      if (typeof inputObject === 'string' && inputObject.length <= 0) {
        return true;
      }
      // Check of empty array
      if (Array.isArray(inputObject) && inputObject.length <= 0) {
        return true;
      }
      // Check of Date object
      if (inputObject instanceof Date) {
        return false;
      }
      // Check of empty object
      if (typeof inputObject === 'object' && Object.keys(inputObject).length <= 0) {
        return true;
      }
      return false;
    }
  },
  browser: {
    isLoadFromHistory: () => {
      return window.navigation.canGoForward;
    }
  }
}

const { BehaviorSubject } = rxjs;
// Create State manager to manage the state change on this page and set default to standby
const stateManagerBS$                 = new BehaviorSubject(GeneralService.constant.state.standby);
let dataGridloadingIndicator          = document.getElementById('dataGridloadingIndicator');
let resultContainer                   = document.getElementById('resultContainer');
let errorMessageContainer             = document.getElementById('errorMessageContainer');
let unavailableContainer              = document.getElementById('unavailableContainer');
let searchControl                     = document.getElementById('searchControl');
let mainForm                          = document.search;
let workCueSearchOptionContainer      = document.getElementById('workCueSearchOptionContainer');
let cueTitleContainer                 = document.getElementById('cueTitleContainer');
let audioVisualCueIdentifierContainer = document.getElementById('audioVisualCueIdentifierContainer');


/**
 * Hide all UI containers
 */
let clearUI = () => {
  dataGridloadingIndicator.style.display = 'none';
  resultContainer.style.display          = 'none';
  errorMessageContainer.style.display    = 'none';
  unavailableContainer.style.display     = 'none';
  searchControl.disabled                 = false;
}

let dataLoading = () => {
  clearUI();
  searchControl.disabled = true;
  dataGridloadingIndicator.style.display = 'block';
}

let dataLoadingCompleted = () => {
  clearUI();
  resultContainer.style.display = 'block';
}

let showErrorMessage = () => {
  clearUI();
  errorMessageContainer.style.display = 'block';
}

let showUnavailable = () => {
  clearUI();
  unavailableContainer.style.display = 'block';
}

let onStateChanged = (state) => {
  switch (state) {
    case GeneralService.constant.state.standby:
      break;
    case GeneralService.constant.state.inProgress:
      dataLoading();
      break;
    case GeneralService.constant.state.completed:
      dataLoadingCompleted();
      break;
    case GeneralService.constant.state.error:
      showErrorMessage();
      break;
    case GeneralService.constant.state.unavailable:
      showUnavailable();
      break;
    default:
      break;
  }
}

let formActionResponse = () => {
}

let isFormValid = () => {
  // return false;
  return (
      audioVisualCueIdentifierContainer.disabled
      || workCueSearchOptionContainer.disabled
    );
}

const resetSearchFormAccessibility = () => {
  workCueSearchOptionContainer.disabled = false;
  cueTitleContainer.disabled = false;
  audioVisualCueIdentifierContainer.disabled = false;
}

const setSearchFormAccessibility = () => {
  if(
    mainForm.productionTitle.value.length > 0
    || mainForm.cueTitle.value.length > 0
  ) {
    audioVisualCueIdentifierContainer.disabled = true;
  }else if(mainForm.cueIdentifier.value.length > 0) {
    workCueSearchOptionContainer.disabled = true;
    cueTitleContainer.disabled = true;
  }
}

let onFormChanged = (evt) => {
  resetSearchFormAccessibility();
  setSearchFormAccessibility();

  searchControl.disabled = !isFormValid();
}


// Initial main form
let initForm = () => {
  // set initial focus
  mainForm.productionTitle.focus();
  searchControl.disabled = !isFormValid();
}


// Initial setup for the page
let init = () => {
  initForm();

  stateManagerBS$.subscribe({
    next: onStateChanged,
    error: (e) => console.error(e),
    complete: () => console.info('stateManagerBS$ completed')
  });

  // Detect Search form on change
  const onMainFormChange$ = fromEvent(mainForm, 'input');
  onMainFormChange$.subscribe({
    next: onFormChanged,
    error: (e) => console.error(e),
    complete: () => console.info('onMainFormChange$ completed')
  });

}

init();
```