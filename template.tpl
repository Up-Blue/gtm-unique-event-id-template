___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "categories": ["UTILITY", "ADVERTISING"],
  "version": 1,
  "securityGroups": [],
  "displayName": "Unique Event ID by Up Blue",
  "description": "Generuje unikalny identyfikator zdarzenia na potrzeby deduplikacji Meta CAPI i GA4.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const copyFromDataLayer = require('copyFromDataLayer');
const setInWindow = require('setInWindow');
const copyFromWindow = require('copyFromWindow');
const getTimestampMillis = require('getTimestampMillis');
const generateRandom = require('generateRandom');

const gtmId = copyFromDataLayer('gtm.uniqueEventId');
const finalGtmId = (gtmId || gtmId === 0) ? gtmId : '00';

let gtmBrowserId = copyFromWindow('gtmBrowserId');
if (!gtmBrowserId) {
  gtmBrowserId = getTimestampMillis() + generateRandom(100000, 999999);
  setInWindow('gtmBrowserId', gtmBrowserId, false);
}

let pageLoadId = copyFromWindow('gtmPageLoadId');
if (!pageLoadId) {
  pageLoadId = getTimestampMillis() + generateRandom(100000, 999999);
  setInWindow('gtmPageLoadId', pageLoadId, false);
}

return gtmBrowserId + "_" + pageLoadId + finalGtmId;


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "gtmBrowserId"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "gtmPageLoadId"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedKeys",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "gtm.uniqueEventId"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Output Validation
  code: |-
    const mockDataLayerValue = 123;
    const mockTimestamp = 1647430000000;
    const mockRandom = 555555;

    mock('copyFromDataLayer', (key) => {
      if (key === 'gtm.uniqueEventId') return mockDataLayerValue;
      return undefined;
    });

    mock('getTimestampMillis', () => mockTimestamp);
    mock('generateRandom', () => mockRandom);
    mock('copyFromWindow', (key) => undefined);
    mock('setInWindow', (key, val, push) => true);

    const result = runCode();

    const expectedPart = '1647430000000_555555';
    const expectedFullMatch = expectedPart + '.' + expectedPart + '.123';

    assertThat(result).isEqualTo(expectedFullMatch);


___NOTES___

Created on 16.03.2026, 13:11:00


