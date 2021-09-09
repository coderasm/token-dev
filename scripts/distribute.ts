import { run, ethers, network } from "hardhat";
import Config from "./config.json";
import { Networks } from "./enums/Networks";

async function main() {
  await run("compile");
  try {
    var activeNetwork: Networks = Networks[network.name];
    const tokenFactory = await ethers.getContractFactory(Config.contract);
    const token = await tokenFactory.attach(Config.networks[activeNetwork].addresses.contract);
    const accounts = await ethers.getSigners();
    const sniping = accounts[3];
    const gas = 300000
    var dividendTokenBalance = await token.dividendTokenBalanceOf(sniping.address);
    var dividendTokenDivisor = ethers.BigNumber.from(10).pow(9);
    console.log(`Dividend token balance: ${dividendTokenBalance.div(dividendTokenDivisor)}`);
    var withdrawableDividend = await token.withdrawableDividendOf(sniping.address);
    console.log(`Withdrawable dividend: ${ethers.utils.formatEther(withdrawableDividend)}`);
    var tx = await token.processDividendTracker(gas);
    var result = tx.wait();
    if(result.status == 1)
      console.log(`Processed Dividend Tracker`);
}
catch(e) {
  console.log(e);
}
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });