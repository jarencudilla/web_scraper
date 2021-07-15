const pcp3 = require("/home/jarenc/Rails_Activities/web_scraper/dist")

async function returnParts() {
  let parts = await pcp3.getPartsList('test')
  console.log(parts)
}
returnParts()