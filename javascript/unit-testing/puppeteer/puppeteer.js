/**
 * Usage:
cd C:\Users\zk9wufn\ls\me\development\nodejs\automation\
call C:\Users\zk9wufn\ls\me\development\batch\dos\cmd-start-node_8_12_0.bat

node unit-test.js ./test-case/hudson-bay.json
node unit-test.js ./test-case/subscription.json
node unit-test.js ./test-case/subscription-bulk-edit.json
node unit-test.js ./test-case/vendor.json
node unit-test.js ./test-case/EQSSUB-2066.json
node unit-test.js ./test-case/EQSSUB-2350.json
node unit-test.js ./test-case/EQSSUB-2540.json
node unit-test.js ./test-case/EQSSUB-1365.json
node unit-test.js ./test-case/EQSSUB-3342.json
node unit-test.js ./test-case/EQSSUB-4919.json
node unit-test.js ./test-case/EQSSUB-4933.json
node unit-test.js ./test-case/EQSSUB-4840.json


cls && node unit-test.js ./test-case/RT-entitlements-trades-internal.json
cls && node unit-test.js ./test-case/RT-entitlements-trades-external.json
cls && node unit-test.js ./test-case/RT-ETF-MLI-APAC.json
cls && node unit-test.js ./test-case/RT-Add-Report-Group.json
cls && node unit-test.js ./test-case/RT-Global-search.json
 */

const puppeteer = require('puppeteer');
const moment = require('moment');
const fs = require("fs");
const mappings = require('./config/element-map.js');



(async () => {
  // console.log('Unit Testing: - (process.argv) ', process.argv);
  let data = fs.readFileSync(process.argv[2], 'utf8');
  // console.log('Unit Testing: - (data) ', data);
  let testData = JSON.parse(data);
  // console.log('Unit Testing: - (mapData) ', mapData);

  const browser = await puppeteer.launch({
    headless: false,
    args: [
      // `--window-size=${testData.settings.window.width},${testData.settings.window.height}`,
      '--start-maximized'
    ],
    executablePath: 'C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe'
  });
  const page = await browser.newPage();

  await page.goto(`${testData.goto}`, {
    waitUntil: 'networkidle2'
  });
  await page.setViewport({
    width: testData.settings.window.width,
    height: testData.settings.window.height
  });

  for (var i = 0, len = testData.action.length; i < len; i++) {
    await executeAction(page, testData.settings, testData.action[i], testData.name);
  }

  await page.waitFor(testData.settings.delayBeforeClose);
  await browser.close();
})();

async function executeAction(page, settings, actionItem, testName) {

  
  let capture = async (subFolder, prefix) => {
    let currentDate = moment().format('YYYYMMDD');
    if (!fs.existsSync(currentDate)) {
      fs.mkdirSync(currentDate);
    }
    if (!fs.existsSync(`${currentDate}/${subFolder}`)) {
      fs.mkdirSync(`${currentDate}/${subFolder}`);
    }
    await page.screenshot({
      path: `./${currentDate}/${subFolder}/${moment().format('YYYYMMDD-HHmmss')}-${prefix}.png`,
      fullPage: true
    });
  }

  let clickOption = {delay: 500};

  console.log('executeAction: - (actionItem.waitForSelector) ', actionItem.waitForSelector);
  console.log('executeAction: - (actionItem.target) ', actionItem.target);
  // console.log('executeAction: - (mappings.elementMap) ', mappings.elementMap);
  let targetSelector = actionItem.target;
  
  if(actionItem.target && actionItem.target.startsWith('~')){
    let selectorRef = actionItem.target.substr(1); 
    targetSelector = mappings.elementMap[selectorRef];
  }
  console.log('executeAction: - (targetSelector) ', targetSelector);

  if (actionItem.waitForSelector) {
    if(actionItem.action.endsWith('x')) {
      await page.waitForXPath(targetSelector);
    } else {
      await page.waitForSelector(targetSelector);
    }
    // await page.waitFor(settings.actionDelayTime);
    // await page.waitFor(actionItem.actionDelayTime);
  }

  console.log('executeAction: - (actionItem.action) ', actionItem.action);

  switch (actionItem.action) {
    case 'input':
      await page.waitForSelector(targetSelector);
      await page.type(targetSelector, actionItem.inputValue, {
        delay: actionItem.inputDelay
      });
      break;
    case 'inputx':
      // Input on xPath
      const targetXpathInputElement = await page.$x(targetSelector);
      await targetXpathInputElement[0].type(actionItem.inputValue, {
        delay: actionItem.inputDelay
      });
      break;
    case 'radio':
      await page.waitForSelector(targetSelector);
      const radioButton = await page.$(targetSelector);
      await radioButton.click();
      break;
    case 'click':
      await page.click(targetSelector, clickOption);
      break;
    case 'select':
      await page.select(targetSelector, actionItem.inputValue);
      break;
    case 'clickx':
      // click on xPath
      const targetXpathElement = await page.$x(targetSelector);
      console.log('executeAction: - (targetXpathElement) ', targetXpathElement.length);
      if(targetXpathElement.length > 0) {
        await targetXpathElement[0].click();
      }
      break;
    case 'wait':
      await page.waitFor(actionItem.delayTime);
      break;
    case 'screenshot':
      capture(testName, targetSelector);
      break;
    default:
      console.log('No action');
  }
  console.log('executeAction Exit Action Switch');
  console.log('executeAction: - (actionItem.description) ', actionItem.description);
  page.waitFor(settings.actionDelayTime);

  if (actionItem.capture) {
    await capture(testName, actionItem.capturePrefix);
  }
  console.log('');
  return;
}
