# Create multiple selection dropdown with checkbox

## Use web component from HTML
```html
<wc-multiselect-dropdown
  id="componentId"
  style="display: inline-block;"
  data-label="Select an option"
  dropdown-state="collapse"
  data-change-event-name="onMultipleDropdownEleValueChanged">
</wc-multiselect-dropdown>
```

## Fill dropdown values
```js

let multipleDropdownEle = document.querySelector('#multipleDropdownEle');

let buildDrowdownOptions = (isTitleIncluded) => {
  let options = [];
  options.push({label: `2020`, value: `2020`});
  options.push({label: `2021`, value: `2021`});
  options.push({label: `2022`, value: `2022`});
  options.push({label: `2023`, value: `2023`});
  options.push({label: `2024`, value: `2024`});

  if(isTitleIncluded){
    options.push({label: (pageLanguage === languages.FR) ?'Toutes':'All', value: 'All', isChecked: true});
  }
  multipleDropdownEle.items = options;
}


let onMultipleDropdownEleValueChanged = (values) => {
  // Add your code here to trigger business logic
  console.log('values', values);
}

```

## Create Web Component
```js
/**
 * Version: 4.139
 * Create multiple selection dropdown with checkbox
 */

const template = document.createElement('template');
template.innerHTML = `
<style>
.multiselect {
  width: 200px;
}

.selectBox {
  position: relative;
}

.selectBox select {
  width: 100%;
  font-weight: bold;
}

.overSelect {
  position: absolute;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
}

.disabled-element {
  pointer-events: none;
  opacity: 0.5;
  cursor: not-allowed;
}

#checkboxes {
  display: none;
  border: 1px #dadada solid;
  position: absolute;
  width: 200px;
  background-color: white;
  z-index: 9;
}

#checkboxes label {
  display: FLEX;
  justify-content: flex-start;
  gap: 0.2rem;
  align-items: center;
  padding: 0.1rem 0;
}

#checkboxes label:hover {
  background-color: #1e90ff;
}
</style>

<div class="multiselect">
  <div class="selectBox" >
    <select>
      <option id="displayOption"></option>
    </select>
    <div name="multiSelectDropdown" class="overSelect"></div>
  </div>
  <div id="checkboxes">
  </div>
</div>
`;

// Create a class for the element
class MultiSelectDropdownElement extends HTMLElement {

  static observedAttributes = ["display-state", 'dropdown-state'];

  expanded = false;
  disabled = false;
  _items = [];

  get items() {
    return this._items;
  }

  set items(value) {
    this._items = value;
    this.populateOptions();
  }

  populateOptions = () => {
    const checkboxes = this.root.getElementById("checkboxes");

    checkboxes.innerHTML = '';

    this._items.forEach(item => {
      const optionLabel = document.createElement("label");

      const inputCheckbox = document.createElement("input");
      inputCheckbox.setAttribute("name", "selectedValues");
      inputCheckbox.setAttribute("type", 'checkbox');
      inputCheckbox.setAttribute("value", item.value);
      if(item.isChecked && item.isChecked === true){
        inputCheckbox.checked = true;
        this.updateMainSelectionLabel((pageLanguage === languages.FR)?'Toutes':'All');
      }
      inputCheckbox.addEventListener('click', this.onCheckboxClicked);

      const labelText = document.createElement("span");
      labelText.innerHTML = item.label;
      optionLabel.appendChild(inputCheckbox);
      optionLabel.appendChild(labelText);
      checkboxes.appendChild(optionLabel);
    });
    
    // this.updateMainSelectionLabel(this.getAttribute("data-label"));
  }

  updateMainSelectionLabel = (dataLabel) => {
    const displayOption = this.root.getElementById("displayOption");
    displayOption.textContent = dataLabel;
  }

  reCalculateCheckbox = (value, isChecked) => {
    // console.log('reCalculateCheckbox - (value)    ', value);
    // console.log('reCalculateCheckbox - (isChecked)', isChecked);
    const isAll = /all/i.test(value);
    // console.log('reCalculateCheckbox - (isAll)', isAll);
    if(isAll){
      if(isChecked){
        const allEles = this.root.querySelectorAll('input:not([value="All"]):checked');
        // console.log('reCalculateCheckbox - (allEles)', allEles);
        allEles.forEach(allEle => {
          allEle.checked = false;
        })
      }
    } else {
      const allEle = this.root.querySelector('input[value="All"]');
      // console.log('reCalculateCheckbox - (allEle)', allEle);
      if(allEle){
        allEle.checked = false;
      }
    }
  }

  onCheckboxClicked = (event) => {
    // console.log('onCheckboxClicked - (event)', event);
    this.reCalculateCheckbox(event.target.value, event.target.checked);
    const values = Array
      .from(event.target.parentElement.parentElement.querySelectorAll('input[type="checkbox"]:checked'))
      .map((checkbox) => {
        let value = checkbox.value;
        if(/all/i.test(value)){
          value = (pageLanguage === languages.FR)?'Toutes':'All';
        }
        return value;
      });
      if(values.length > 0){
        this.updateMainSelectionLabel(values.join(','));
      } else {
        this.updateMainSelectionLabel(this.getAttribute("data-label"));
      }
    // console.log('onCheckboxClicked - (values)', values);
    this.dispatchEvent(new CustomEvent(this.getAttribute("data-change-event-name"), { detail: values }));
  }

  onDropdownClicked = (event) => {
    const checkboxes = this.root.getElementById("checkboxes");
    if (!this.expanded) {
      checkboxes.style.display = "block";
      this.expanded = true;
    } else {
      checkboxes.style.display = "none";
      this.expanded = false;
    }
  }

  changedComponentState = () => {
    const multiselect = this.root.querySelector('.multiselect');
    if(this.disabled) {
      multiselect.classList.add('disabled-element');
    } else {
      multiselect.classList.remove('disabled-element');
    }
  }

  // show and hide the checkbox when state changed
  onDisplayStateChanged = (currentValue) => {
    this.disabled = (currentValue === 'disabled');
    this.changedComponentState();
  }

  // show and hide the checkbox when state changed
  onDropdownStateChanged = (currentValue) => {
    this.expanded = !(currentValue === 'expand');
    // console.log(`onDisplayStateChanged - (this.expanded)`, this.expanded);
    this.onDropdownClicked();
  }

  constructor() {
    // Always call super first in constructor
    super();
    // Create a shadow root
    this.root = this.attachShadow({ mode: "open" });

    let clone = template.content.cloneNode(true);
    this.root.append(clone);

    let dropdownComponent = this.root.querySelector('div[name="multiSelectDropdown"]');
    if (!dropdownComponent) return;

    dropdownComponent.addEventListener('click', this.onDropdownClicked);

  }

  connectedCallback() {
    this.updateMainSelectionLabel(this.getAttribute("data-label"));
  }

  disconnectedCallback() {
    console.log("Custom element removed from page.");
  }

  adoptedCallback() {
    console.log("Custom element moved to new page.");
  }

  // Callback when attribute changed
  attributeChangedCallback(name, oldValue, newValue) {
    // console.log(`Attribute ${name} has changed from ${oldValue} to ${newValue}`);
    switch (name) {
      case 'display-state':
        this.onDisplayStateChanged(newValue);
        break;
      case 'dropdown-state':
        this.onDropdownStateChanged(newValue);
        break;
      default:
        break;
    }
  }
}

customElements.define("wc-multiselect-dropdown", MultiSelectDropdownElement);

```