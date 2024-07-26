javascript: (() => {
  let containerSelector = '#main-container > #container';
  let aodaComplianceRules = [
    {
      selector: `h1`,
      label: `&lt;h1&gt;`,
      qualifiedLength: 1,
      isSelectorWithinContainer: false,
      showhtml: true,
    },{
      selector: `table`,
      label: `&lt;table&gt;`,
      qualifiedLength: 0,
      isSelectorWithinContainer: false,
      showhtml: false,
    },{
      selector: `table:not([role="presentation"])`,
      label: `&lt;table&gt; without role="presentation"`,
      qualifiedLength: 0,
      isSelectorWithinContainer: false,
      showhtml: true,
    },{
      selector: `th:not([scope])`,
      label: `&lt;th&gt; without scope`,
      qualifiedLength: 0,
      isSelectorWithinContainer: false,
      showhtml: true,
    },{
      selector: `input:not([type="hidden"]):not([id])`,
      label: `&lt;input&gt; without ID`,
      qualifiedLength: 0,
      isSelectorWithinContainer: false,
      showhtml: true,
    },{
      selector: `input:not([type="hidden"]):not([aria-label])`,
      label: `&lt;input&gt; without aria-label`,
      qualifiedLength: 0,
      isSelectorWithinContainer: false,
      showhtml: true,
    },{
      selector: `input:not([type="hidden"])[aria-label=""]`,
      label: `&lt;input&gt; with Empty aria-label`,
      qualifiedLength: 0,
      isSelectorWithinContainer: false,
      showhtml: true,
    },{
      selector: `select:not([type="hidden"]):not([id])`,
      label: `&lt;select&gt; without ID`,
      qualifiedLength: 0,
      isSelectorWithinContainer: false,
      showhtml: true,
    },{
      selector: `select:not([type="hidden"]):not([aria-label])`,
      label: `&lt;select&gt; without aria-label`,
      qualifiedLength: 0,
      isSelectorWithinContainer: false,
      showhtml: true,
    },{
      selector: `select:not([type="hidden"])[aria-label=""]`,
      label: `&lt;select&gt; with Empty aria-label`,
      qualifiedLength: 0,
      isSelectorWithinContainer: false,
      showhtml: true,
    },{
      selector: `button:not([aria-label])`,
      label: `&lt;button&gt; without aria-label`,
      qualifiedLength: 0,
      isSelectorWithinContainer: false,
      showhtml: true,
    },{
      selector: `a:not([type="hidden"]):not([aria-label])`,
      label: `&lt;a&gt; without aria-label`,
      qualifiedLength: 0,
      isSelectorWithinContainer: false,
      showhtml: true,
    },{
      selector: `a:not([type="hidden"])[aria-label=""]`,
      label: `&lt;a&gt; with Empty aria-label`,
      qualifiedLength: 0,
      isSelectorWithinContainer: false,
      showhtml: true,
    },{
      selector: `img:not([alt]`,
      label: `&lt;img&gt; without alt attribute`,
      qualifiedLength: 0,
      isSelectorWithinContainer: false,
      showhtml: true,
    },{
      selector: `[class="ERROR"]:not([role="alert"]`,
      label: `Error Class without role="alert"`,
      qualifiedLength: 0,
      isSelectorWithinContainer: false,
      showhtml: true,
    }
  ];

  let aodaComplianceResult = aodaComplianceRules.map(rule => {
    return {
      ...rule,
      elements: document.querySelectorAll(`${rule.isSelectorWithinContainer?containerSelector:''} ${rule.selector}`),
    };
  });

  let aodaComplianceHtml = aodaComplianceResult.map(result => {
    let eleAry = Array.from(result.elements);
    console.log('eleAry', eleAry);
    return {
      elementCountHtml: `<div class="col">
      <div class="card mb-4 rounded-3 shadow-sm">
        <div class="card-header py-3">
          <h4 class="my-0 fw-normal">${result.label}</h4>
        </div>
        <div class="card-body">
          ${(eleAry.length === result.qualifiedLength)?`<h1 class="card-title green-text">${eleAry.length}<small class="text-muted fw-light"></small></h1>`:`<h1 class="card-title red-text">${eleAry.length}<small class="text-muted fw-light"></small></h1>`}
        </div>
      </div>
    </div>`,
      elementOuterhtml: (result.showhtml && eleAry.length !== result.qualifiedLength)?`<div class="col" style="display: block;">
      <div class="card mb-4 rounded-3 shadow-sm border-primary">
        <div class="card-header py-3 text-white bg-primary border-primary">
          <h4 class="my-0 fw-normal">${result.label}</h4>
        </div>

        <textarea id="w3review" name="w3review" rows="15" cols="100">
${eleAry.reduce((acc,ele) => {
  acc += `${ele.outerHTML}\n`;
  return acc;
}, '')}
        </textarea>

      </div>
    </div>`:'',
    };
  });

  return `
  <!DOCTYPE html>
  <html><head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>AODA compliance checking Summary</title>
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/slate/bootstrap.min.css" integrity="sha384-8iuq0iaMHpnH2vSyvZMSIqQuUnQA7QM+f6srIdlgBrTSEyd//AWNMyEaSF2yPzNQ" crossorigin="anonymous">

    <style>
      .overflow-anywhere {
        overflow-wrap: anywhere;
      }
      .suppier-no-column {
        width: 100px;
      }
      .publisher-column {
        width: 400px;
      }
      .earnings-column {
        width: 60px;
      }
      .transactions-column {
        width: 100px;
      }
      .record-container-li {
        display: flex;
        justify-content: center;
      }
      .record-container {
        justify-content: space-between;
        width: 300px;
        display: flex;
      }
      .record-label {
        width: 200px;
      }
      .grid-contrainer {
        margin: 50px;
        display: flex;
        justify-content: center;
      }
      .green-text { color: #27ad41; }
      .red-text { color: #e06565; }
    </style>
    <script>var __basePath = './';</script>
    <script>
    </script>
  </head>
  <body>
  <main>
    <h1>AODA compliance checking Summary</h1>
    <div class="row row-cols-1 row-cols-md-4 mb-4 text-center">
      ${aodaComplianceHtml.reduce((acc, htmls) => {
        acc += htmls.elementCountHtml;
        return acc;
      }, '')}
      </div>
      <div class="row row-cols-1 row-cols-md-2 mb-2 text-center">
      ${aodaComplianceHtml.reduce((acc, htmls) => {
        acc += htmls.elementOuterhtml;
        return acc;
      }, '')}

        </div>
  </main>
  </body>
  </html>
`;
})();
