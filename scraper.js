const pcp3 = require("/home/jarenc/Rails_Activities/web_scraper/dist")

async function returnParts() {
  let parts = await pcp3.getPartsList('build 1')
  console.log(parts)
}
returnParts()
