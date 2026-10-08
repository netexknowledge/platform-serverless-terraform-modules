// CommonJS a proposito: desde commitlint 19 el cargador de configs .ts
// (cosmiconfig-typescript-loader v6) exige typescript >=5 como peer, y
// commitlint ya no lo arrastra. Como este fichero solo extiende el preset y
// anade una regla, no compensa mantener toda la cadena de TypeScript.
module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    // 2 = error. Equivale a RuleConfigSeverity.Error, que venia de
    // @commitlint/types y era lo unico que justificaba el fichero .ts.
    'scope-empty': [2, 'never'],
  },
};
