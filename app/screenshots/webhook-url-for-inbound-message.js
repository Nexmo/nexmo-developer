const puppeteer = require('puppeteer')
const fs = require('fs')
const sha1File = require('sha1-file')
require('dotenv').config()

if (!fs.existsSync('./public/assets/screenshots')){
  fs.mkdirSync('./public/assets/screenshots')
}

(async () => {
  const browser = await puppeteer.launch()
  const page = await browser.newPage()
  await page.setViewport({ width: 800, height: 500 })
  await page.goto('https://dashboard.nexmo.com/sign-in')

  await page.waitForSelector('input[name=username]')
  await page.type('input[name=username]', process.env.NEXMO_USERNAME)
  await page.type('input[name=password]', process.env.NEXMO_PASSWORD)
  await page.click('#btn_login')

  await page.waitForSelector('#nav-expander')
  await page.goto('https://dashboard.nexmo.com/settings')

  await page.waitForSelector('#nav-expander')
  await page.click('#httpBaseUrlForMoPost')

  await page.addStyleTag({
    content: `
      #sysId, #password, #signatureSecret {
        filter: blur(5px)
      }
    `
  })

  await page.screenshot({ path: 'public/assets/screenshots/tmp.png' })

  const sha = sha1File('public/assets/screenshots/tmp.png')
  const newPath = `public/assets/screenshots/${sha}.png`
  fs.renameSync('public/assets/screenshots/tmp.png', newPath)

  await browser.close()

  console.log(newPath)
})()
