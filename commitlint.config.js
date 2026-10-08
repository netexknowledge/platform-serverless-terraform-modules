// CommonJS: la imagen de wagoid/commitlint-github-action trae commitlint y
// config-conventional, pero no TypeScript, asi que el config no puede ser .ts.
module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    // 2 = error. Era RuleConfigSeverity.Error, que venia de @commitlint/types
    // y era lo unico que justificaba que este fichero fuese TypeScript.
    'scope-empty': [2, 'never'],
  },
};
