'use strict';

// eslint-disable-next-line node/no-unpublished-require
const EmberApp = require('ember-cli/lib/broccoli/ember-app');

module.exports = function (defaults) {
  const app = new EmberApp(defaults, {
    // Add options here
    autoImport: {
      watchDependencies: ['ember-composable-helpers'],
    },
  });
  
  // eslint-disable-next-line node/no-unpublished-require
  const { maybeEmbroider } = require('@embroider/test-setup');

  return maybeEmbroider(app);
};
