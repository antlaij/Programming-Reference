
---
> ### Component
---
> #### Different between Class Component and Function Component
No need to import Component
Where to use:
Top level component usually use class component
Use ES6 Functional component for presentational layer component
'state' is only available in class component
setState is Async process
---
> #### Class Component
Should allow only one parent tag
In Class component, it automatically get props
```html
  <Users typeOfUser="Admin" />
```
```jsx
import React, { Component } form 'react';

class Users extends Component {
  state = {
    pageTitle: 'This is a test title',
    products: [
      { name: 'tv', price: 199.99 },
      { name: 'computer', price: 599.99 },
      { name: 'phone', price: 399.99 },
    ]
  }

  onUserClick = () => {
    this.setState(
      products: [
        { name: 'tv', price: 999.99 },
        { name: 'computer', price: 888.99 },
        { name: 'phone', price: 111.99 },
      ]
    );
  }

  render() {
    return (
      <div>
        This is a test
        {this.props.typeOfUser}
        {
          this.state.products.map(product => (
            return <div>{product.name}, {product.price}</div>
          ))
        }
      </div>
    )
  }
}
```
---
> #### Function Component
Should allow only one parent tag
In functional component, it needs to use props to pass data to the component
```html
  <User username="superuser" >John</User>
```
```tsx
import React form 'react';

const Users: React.FC = (props) => {
    return (
      <div>
        Show 'John' in UI
        {props.children}
        Show 'superuser' in UI
        {props.username}
      </div>
    )
}

export default Users
```

---
> ### Hooks
---
> #### useState hook
useState has run in the same order
Try to use function version of the useState
```jsx
  const [myVaraible, setMyVaraible] = useState(0);
  const [myVaraible, setMyVaraible] = useState(() => {
    console.log('calling useState myVaraible');
    return 0;
  });

const changMyVaraible = () => {
    setMyVaraible( prevValue => prevValue + 1);
  }
```

---
> ### Class and For
---
> #### For CSS class, need to use className
```jsx
      <div className="my-style-class-name">
      </div>
```
> #### For For
```jsx
      <div htmlFor="for-name">
      </div>
```

---
> ### Routing
---
> #### Route with render
```jsx
import { Route, Link } from 'react-router-dom';

      <Route
        path="/"
        exact
        render={() => (
          <div>
            This is the generated root route.{' '}
            <Link to="/page-2">Click here for page 2.</Link>
          </div>
        )}
      />
      <Route
        path="/page-2"
        exact
        render={() => (
          <div>
            <Link to="/">Click here to go back to root page.</Link>
          </div>
        )}
      />

```

---
> #### Route with component
```jsx
import { Route, Link } from 'react-router-dom';

      <Route path="/" exact component={Home} />
      <Route path="/about" exact component={About} />
      <Route path="/product/:id/:name" exact component={ProductDetail} />

```

---
> #### Route Get data from url
```html
<a href="localhost/product/33242423">link</a>
```
```jsx
import { Route, Link } from 'react-router-dom';

function ProductDetail ({match}) {
  return (<div>Product ID: {match.params.id}</div>)
}
```

---
> #### Router Redirect
```html
      <Route path="/Forecast" exact strict
        render={({match}) => (
        this.state.loggedIn ? ( <User username={match.params.username} /> ) : ( <Redirect to='/' /> )
      )} />
```
```tsx
```

---
> #### Router Promt
```html
      <Promt
        when={!this.state.loggedIn}
        message={(location) => {
          retrun location.pathname.startsWith('/user') ? 'Are you sure ?' : true
        }}
      />
```
```tsx
```

---
> #### Router with hooks useParams
```html
<a href="localhost/product/33242423/niceProduct">link</a>
```
```tsx
import { useParams } from 'react-router';

function ProductDetail ({match}) {
  const {id, name} = useParams();
  return (<div>Product ID: {id} - {name}</div>)
}
```


