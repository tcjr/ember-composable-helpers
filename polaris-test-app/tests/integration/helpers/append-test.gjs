import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render, settled } from '@ember/test-helpers';
import append from 'ember-composable-helpers/helpers/append';
import { TrackedArray } from 'tracked-built-ins';
import { tracked } from '@glimmer/tracking';

module('Integration | Helper | {{append}}', function (hooks) {
  setupRenderingTest(hooks);

  test('It concats two arrays', async function (assert) {
    const evens = [2, 4, 6];
    const odds = [1, 3, 5];

    await render(<template>
          {{~#each (append evens odds) as |n|~}}
            {{n}}
          {{~/each~}}
        </template>);

    let expected = '246135';

    assert.dom().hasText(expected, 'appends values');
  });

  test('It concats two arrays and a value', async function (assert) {
    const evens = [4, 6];
    const odds = [1, 3, 5];
    const prime = 2;

    await render(<template>
          {{~#each (append evens odds prime) as |n|~}}
            {{n}}
          {{~/each~}}
        </template>);

    let expected = '461352';

    assert.dom().hasText(expected, 'appends values');
  });

  test('It watches for changes, @tracked', async function (assert) {
    class State {
      @tracked odds = [];
    }
    const state = new State();
    state.odds = [1, 3, 5];
    const prime = 2;

    await render(<template>
          {{~#each (append state.odds prime) as |n|~}}
            {{n}}
          {{~/each~}}
        </template>);

    state.odds = [...state.odds, 7];
    await settled();
    assert.dom().hasText('13572', 'new value is added');
  });

  test('It watches for changes, TrackedArray', async function (assert) {
    const odds = new TrackedArray();
    odds.push(1, 3, 5);
    const prime = 2;

    await render(<template>
          {{~#each (append odds prime) as |n|~}}
            {{n}}
          {{~/each~}}
        </template>);

    odds.push(7);
    await settled();
    assert.dom().hasText('13572', 'new value is added');
  });

  test('it allows null array', async function (assert) {
    const array = null;

    await render(<template>
          {{~#each (append 1 array) as |value|~}}
            {{~value~}}
          {{~/each~}}
        </template>);

    assert.dom().hasText('1', 'no error is thrown');
  });
});
