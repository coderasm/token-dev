import { run, ethers, network } from "hardhat";
import * as Config from "./config.json";
import { Networks } from "./enums/Networks";

async function main() {
  await run("compile");
  try {
    var activeNetwork: Networks = Networks[network.name];
    const routerFactory = await ethers.getContractFactory("Router");
    const router = await routerFactory.attach(Config.networks[activeNetwork].addresses.router);
    const tokenFactory = await ethers.getContractFactory(Config.contract);
    const token = await tokenFactory.attach(Config.networks[activeNetwork].addresses.contract);
    const Pair = await ethers.getContractFactory("Pair");
    const accounts = await ethers.getSigners();
    const admin = accounts[0].address;
    const marketing = accounts[1].address;

    console.log(token.address);
    const contractBalance = await ethers.provider.getBalance(token.address);
    console.log(ethers.utils.formatEther(contractBalance));
    
    console.log(admin);
    const adminBalance = await ethers.provider.getBalance(admin);
    console.log(ethers.utils.formatEther(adminBalance));
    console.log(await token.pancakeswapV2Pair());
    console.log(`admin balance: ${await token.balanceOf(admin)}`);

    //Calculating amounts to move
    const totalSupplyBN = await token.totalSupply();
    console.log(`total supply: ${totalSupplyBN}`);
    const totalSupply = ethers.BigNumber.from(totalSupplyBN.toString());
    const burnAmount = totalSupply.div(2);
    const marketingAmount = totalSupply.mul(499).div(10000);
    const liquidity = totalSupply.sub(burnAmount.add(marketingAmount));

    //Burn
    await burn();

    //Move to marketing
    await moveToMarketing();

    //Add liquidity
    await addLiquidity();

    async function burn() {
      console.log(`burn amount: ${burnAmount}`);
      await token.transfer(Config.networks[activeNetwork].addresses.dead, burnAmount);
    }

    async function moveToMarketing() {
      console.log(`marketing amount: ${marketingAmount}`);
      await token.transfer(marketing, marketingAmount);
    }

    async function addLiquidity() {
      const amountIn = ethers.utils.parseEther(Config.liquidity);
      console.log(`liquidity: ${liquidity}`);
      await token.approve(router.address, liquidity);
      const txHash = await router.addLiquidityETH(
        token.address,
        liquidity,
        liquidity,
        amountIn,
        admin,
        Math.floor(Date.now() / 1000) + 60 * 10,
        {from: admin, value: amountIn} //Adding 1 BNB for liquidity
      );
      const pairAddress = await token.pancakeswapV2Pair();
      const pair = await Pair.attach(pairAddress);
      console.log(`balance LP: ${await pair.balanceOf(admin)}`);
      console.log(`admin balance: ${await token.balanceOf(admin)}`);
      console.log(`marketing balance: ${await token.balanceOf(marketing)}`);
      console.log(`dead balance: ${await token.balanceOf(Config.networks[activeNetwork].addresses.dead)}`);
    }
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