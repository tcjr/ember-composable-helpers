'use strict';

module.exports = {
  extends: 'recommended',
  rules: {
    'no-curly-component-invocation': { allow: ['inc', 'dec'] },
    // grandfather these in for now
    'no-action': false,
  },
};
