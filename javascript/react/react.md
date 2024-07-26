# Reactjs
## Table of Contents
  1. [Component](#Component)
      1. [Reactjs component must starts with Uppercase name](#Reactjs-component-must-starts-with-Uppercase-name)
      1. [Pass properties to component](#Pass-properties-to-component)
      1. [Inputs](#Inputs)
      1. [Conditional Content Renderring](#Conditional-Content-Renderring)
      1. [Content Projection](#Content-Projection)
          1. [Use Children Props](#Use-Children-Props)
          1. [Multi slot content projection](#Multi-slot-content-projection)
              1. [Use Prop name call ch](#Use-Prop-name-call-ch)
              1. [Parent component](#Parent-component)
              1. [Child component](#Child-component)
      1. [Hooks](#Hooks)
          1. [Built-in Hooks](#Built-in-Hooks)
              1. [State Hooks](#State-Hooks)
              1. [Effect Hooks](#Effect-Hooks)
                  1. [Dependencies](#Dependencies)
              1. [useMemo Hooks](#useMemo-Hooks)
                  1. [Referential equality for useMemo when comparing object](#Referential-equality-for-useMemo-when-comparing-object)
  1. [State Management](#State-Management)
      1. [Use Context Provider to share state between different component](#Use-Context-Provider-to-share-state-between-different-component)
          1. [createContext](#createContext)
---
## Component
---
### Reactjs component must starts with Uppercase name
Because the lowercase html tag, react compiler will think that is a regular html tag
Uppercase name will consider custom component function


### Pass properties to component
```html
<MyComponent name="abc"></MyComponent>
```
```jsx
function MyComponent(props) {
  return (
    <div>
      <p>{props.author}</p>
      <p>{props.body}</p>
    </div>
  );
}

export default Post;
```

### Inputs
In React there are three kinds of inputs that you can read while rendering: props, state, and context.


### Conditional Content Renderring
```jsx
ConditionalContentComponent() => {
  const [shouldShowContent, setShouldShowContent] = useState(true);

  function hideModalHandler() {
    setShouldShowContent(false);
  }

  return (
    <>
      {shouldShowContent && (
        <div>This the conditional content</div>
      )}
    </>
  );
}

export default ConditionalContentComponent;
```


### Content Projection
---
#### Use Children Props
```html
<MyComponent>
  <div class="class-selector">testing</div>
  <div class="class-selector-01">testing 01</div>
  <div >No selector content</div>
</MyComponent>
```
---
#### Multi slot content projection
##### Use Prop name call ch
##### Parent component
```html
<MyComponent>
  <div class="class-selector">testing</div>
  <div class="class-selector-01">testing 01</div>
  <div >No selector content</div>
</MyComponent>
```
##### Child component
```jsx
function MyComponent({ children }) {
  return (
    <div>
      {children}
    </div>
  );
}

export default Modal;
```


### Hooks
---
#### Built-in Hooks
##### State Hooks
This will store the value in state
```jsx
const [state, setState] = useState(initialState)
```
```jsx
function ImageGallery() {
  // This run everytime
  const [index, setIndex] = useState(0);
  // OR
  // This will only run once
  const [index, setIndex] = useState(() => {
    console.log('calling useState myVaraible');
    return 0;
  });
}
```
##### Effect Hooks
Effects let you run some code after rendering
```jsx
useEffect(setup, dependencies?)
```
###### Dependencies
1. Passing a dependency array
    - Effect runs after the initial render and after re-renders with changed dependencies.
2. Passing an empty dependency array
    - It will only run after the initial render.
3. Passing no dependency array at all
    - Effect runs after every single render (and re-render) of your component.

```jsx
const FunctionComponent = () => {
  useEffect(() => {
    window.scrollTo(0, 0);
    return () => {
      console.log('clean up function here');
    }
  }, []);

  return (
    <>
      <span>test 1</span>
      <span>test 2</span>
    </>
  );
}
export default FunctionComponent;
```

##### useMemo Hooks
useMemo is a React Hook that lets you cache the result of a calculation between re-renders.
```jsx
const cachedValue = useMemo(calculateValue, dependencies)
```
```jsx
const FunctionComponent = () => {
  const [number, setNumber] = useState(0);
  const visibleTodos = useMemo(() => plusTwo(number), [number]);

  return (
    <>
      <span>test 1</span>
      <span>test 2</span>
    </>
  );
}
export default FunctionComponent;

function plusTwo(num) {
  for(let i=-; i<1_000_000; i++>){}
  return num + 2;
}
```

###### Referential equality for useMemo when comparing object
```jsx
const FunctionComponent = () => {
  const [theme, setTheme] = useState('dark');
  const themeStyles = useMemo(() => {
    return {
      currentTheme: theme
    }
  });
  useEffect(() => {
    console.log('called');
  }, [themeStyles])

  return (
    <>
      <span>test 1</span>
      <span>test 2</span>
    </>
  );
}
export default FunctionComponent;

function plusTwo(num) {
  for(let i=-; i<1_000_000; i++>){}
  return num + 2;
}
```


## State Management
### Use Context Provider to share state between different component
#### createContext
```tsx
import { Trip } from '@mono-repo-workspace/models';
import { createContext, useState, FC, ReactNode } from 'react';

const FavoritesContext = createContext({
  favorites: [] as Trip[],
  totalFavorites: 0,
  // eslint-disable-next-line @typescript-eslint/no-empty-function
  addFavorite: (tripId: Trip) => {},
  // eslint-disable-next-line @typescript-eslint/no-empty-function
  removeFavorite: (tripId: string) => {},
  // eslint-disable-next-line @typescript-eslint/no-empty-function
  isTripFavorite: (tripId: string) => !!tripId
});

export const FavoritesContextProvider: FC<{ children: ReactNode }> = ({children}) => {
  const [userFavorites, setUserFavorites] = useState<Trip[]>([]);

  const addFavoriteHandler = (favoriteMeetup: Trip) => {
    setUserFavorites((prevUserFavorites) => {
      return prevUserFavorites.concat(favoriteMeetup);
    });
  }

  const removeFavoriteHandler = (tripId: string) => {
    setUserFavorites(prevUserFavorites => {
      return prevUserFavorites.filter(meetup => meetup.id !== tripId);
    });
  }

  const itemIsFavoriteHandler = (tripId: string) => {
    return userFavorites.some(meetup => meetup.id === tripId);
  }

  const context = {
    favorites: userFavorites,
    totalFavorites: userFavorites.length,
    addFavorite: addFavoriteHandler,
    removeFavorite: removeFavoriteHandler,
    isTripFavorite: itemIsFavoriteHandler
  };

  return (
    <FavoritesContext.Provider value={context}>
      {children}
    </FavoritesContext.Provider>
  );
}

export default FavoritesContext;
```
































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

---
> ### Error Handling
---
> #### Use Error Boundaries
```jsx
import React from 'react';

class ErrorBoundary extends React.Component {
  state = { hasError: false };

  static getDerivedStateFromError(error) {
    return { hasErrro: true; }
  }

  componentDidCatch(error, info) {
    console.log(error, info);
  }

  render() {
    if(this.state.hasError){
      return this.props.fallback;
    }
    return thsi.props.children;
  }
}

export default ErrorBoundary;

```


