const ENV = process.env.npm_lifecycle_event;
const runOnce = ENV === 'test:once' || ENV === 'test:once:ci';

module.exports = function(config) {
  const testWebpackConfig = require('./webpack.test.js');

  const configuration = {
    basePath: '',
    frameworks: ['jasmine'],
    exclude: [ ],
    files: [ { pattern: './test-config/spec-bundle.js', watched: false } ],
    preprocessors: { './test-config/spec-bundle.js': ['coverage', 'webpack', 'sourcemap'] },
    webpack: testWebpackConfig,

    coverageReporter: {
      type: 'in-memory'
    },

    remapCoverageReporter: {
      'text-summary': null,
      json: './coverage/coverage.json',
      html: './coverage/html'
    },
    webpackServer: { noInfo: true },
    reporters: [ 'mocha', 'coverage', 'remap-coverage' ],
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: !runOnce,
    browsers: [
      'Chrome'
    ],

    customLaunchers: {
      Chrome_travis_ci: {
        base: 'Chrome',
        flags: ['--no-sandbox']
      }
    },
    singleRun: runOnce
  };

  if(process.env.TRAVIS){
    configuration.browsers = ['Chrome_travis_ci'];
  }

  config.set(configuration);
};
