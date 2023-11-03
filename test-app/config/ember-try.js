"use strict";

const getChannelURL = require("ember-source-channel-url");
const { embroiderOptimized, embroiderSafe } = require("@embroider/test-setup");

module.exports = async function () {
  return {
    scenarios: [
      {
        name: "ember-lts-4.4",
        npm: {
          devDependencies: {
            "@ember/test-helpers": "2.7.0",
            "ember-qunit": "6.0.0",
            "ember-source": "~4.4.0",
          },
        },
      },
      {
        name: "ember-lts-4.8",
        npm: {
          devDependencies: {
            "ember-source": "~4.8.0",
          },
        },
      },
      {
        name: "ember-lts-4.12",
        npm: {
          devDependencies: {
            "ember-source": "~4.12.0",
          },
        },
      },
      {
        name: "ember-release",
        npm: {
          devDependencies: {
            "ember-source": await getChannelURL("release"),
          },
        },
      },
      {
        name: "ember-beta",
        npm: {
          devDependencies: {
            "ember-source": await getChannelURL("beta"),
          },
        },
      },
      {
        name: "ember-canary",
        npm: {
          devDependencies: {
            "ember-source": await getChannelURL("canary"),
          },
        },
      },
      embroiderSafe(),
      embroiderOptimized(),
    ],
  };
};
