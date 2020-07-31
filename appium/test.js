const wdio = require('webdriverio');
const assert = require('assert');
const find = require('appium-flutter-finder');

// const osSpecificOps = process.env.APPIUM_OS === 'android' ? {
//   platformName: 'Android',
//   deviceName: 'Pixel2',
//   // @todo support non-unix style path
//   app: __dirname +  '/../build/app/outputs/apk/debug/app-debug.apk',
// }: process.env.APPIUM_OS === 'ios' ? {
//   platformName: 'iOS',
//   platformVersion: '12.2',
//   deviceName: 'iPhone X',
//   noReset: true,
//   app: __dirname +  '/../ios/Runner.zip',
//
// } : {};

const opts = {
  port: 4723,
  capabilities: {
    deviceName: 'Pixel2',
    // @todo support non-unix style path
    app: __dirname +  '/../build/app/outputs/apk/debug/app-debug.apk',
    automationName: 'Flutter',
    platformName: 'Android'
  }
};

(async () => {
  console.log('Initial app testing')
  const driver = await wdio.remote(opts);
   assert.strictEqual(await driver.execute('flutter:checkHealth'), 'ok');
  await driver.execute('flutter:clearTimeline');
  await driver.execute('flutter:forceGC');

  //Enter login page
  await driver.execute('flutter:waitFor', find.byValueKey('loginBtn'));
  await driver.elementSendKeys(find.byValueKey('emailTxt'), 'test@gmail.com')
  await driver.elementSendKeys(find.byValueKey('passwordTxt'), '123456')
  await driver.elementClick(find.byValueKey('loginBtn'));

  //Enter home page
  await driver.execute('flutter:waitFor', find.byValueKey('homeGreetingLbl'));
  assert.strictEqual(await driver.getElementText(find.byValueKey('homeGreetingLbl')), 'Welcome to Home Page');

  //Enter Page1
  await driver.elementClick(find.byValueKey('page1Btn'));
  await driver.execute('flutter:waitFor', find.byValueKey('fullname'));
  await driver.switchContext('NATIVE_APP');
  await (await driver.$("//android.widget.EditText[@text='Full Name']")).click();
  await driver.saveScreenshot('./native-screenshot.png');
  await driver.back();
  await driver.switchContext('FLUTTER');

  //Enter Page2
  await driver.elementClick(find.byValueKey('page2Btn'));
  await driver.execute('flutter:waitFor', find.byValueKey('page2GreetingLbl'));
  await driver.saveScreenshot('./flutter-screenshot.png');
  assert.strictEqual(await driver.getElementText(find.byValueKey('page2GreetingLbl')), 'Page2');
  await driver.elementClick(find.byValueKey('backBtn'));

  driver.deleteSession();
})();
