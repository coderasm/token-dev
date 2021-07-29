import { run, ethers, network } from "hardhat";
import * as Config from "./config.json";
import { Networks } from "./enums/Networks";

async function main() {
  await run("compile");
  try {
    var activeNetwork: Networks = Networks[network.name];
    const tokenFactory = await ethers.getContractFactory(Config.contract);
    const token = await tokenFactory.attach(Config.networks[activeNetwork].addresses.contract);
    const claimerFactory = await ethers.getContractFactory(Config.claimer);
    const claimer = await claimerFactory.attach(Config.networks[activeNetwork].addresses.claimer);
    const Pair = await ethers.getContractFactory("Pair");
    const pairAddress = await token.pancakeswapV2Pair();
    const pair = await Pair.attach(pairAddress);
    const tokenDecimals = await token.decimals();
    const tokenDivisor = ethers.BigNumber.from(10).pow(tokenDecimals);
    const lpDecimals = await pair.decimals();
    const lpDivisor = ethers.BigNumber.from(10).pow(lpDecimals);
    const accounts = await ethers.getSigners();
    const admin = accounts[0].address;
    const marketing = accounts[1].address;
    const buyback = accounts[2].address;

    console.log(`Contract Address: ${token.address}`);
    console.log(`Claimer Address: ${claimer.address}`);
    console.log(`Pair Address: ${pairAddress}`);
    console.log(`Claimer address on contract: ${await token._claimerAddress()}`);
    console.log(`Contract address on claimer: ${await claimer._tokenAddress()}`);
    var claimerBalance = await ethers.provider.getBalance(claimer.address);
    console.log(`Claimer Balance: ${ethers.utils.formatEther(claimerBalance)}`);
    var totalRewards = await token.totalRewards()
    console.log(`Total rewards: ${ethers.utils.formatEther(totalRewards)}`);
    console.log(`Trading Enabled: ${await token.tradingEnabled()}`);
    console.log(`Admin LP Balance: ${(await pair.balanceOf(admin)).div(lpDivisor)}`);
    console.log(`Admin token balance: ${(await token.balanceOf(admin)).div(tokenDivisor)}`);
    console.log(`Marketing token balance: ${(await token.balanceOf(marketing)).div(tokenDivisor)}`);
    console.log(`Burned tokens: ${(await token.balanceOf(Config.networks[activeNetwork].addresses.dead)).div(tokenDivisor)}`);
    console.log(`Burned LP: ${(await pair.balanceOf(Config.networks[activeNetwork].addresses.dead)).div(lpDivisor)}`);
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