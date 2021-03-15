module.exports = {
  name: 'eyes_selenium_ruby',
  emitter: 'https://raw.githubusercontent.com/applitools/sdk.coverage.tests/master/ruby/initialize.js',
  overrides: '../../../../../coverage_tests/overrides.js',
  template: 'https://raw.githubusercontent.com/applitools/sdk.coverage.tests/master/ruby/template.hbs',
  ext: '_spec.rb',
  outPath: './spec/coverage/generic'
}
