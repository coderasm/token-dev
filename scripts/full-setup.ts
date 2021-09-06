import { run, ethers, network } from "hardhat";
import Config from "./config.json";
import { Networks } from "./enums/Networks";

async function main() {
  await run("compile");
  try {
    var activeNetwork: Networks = Networks[network.name];
    const routerFactory = await ethers.getContractFactory("Router");
    const router = await routerFactory.attach(Config.networks[activeNetwork].addresses.router);
    const tokenFactory = await ethers.getContractFactory(Config.contract);
    const token = await tokenFactory.attach(Config.networks[activeNetwork].addresses.contract);
    const claimerFactory = await ethers.getContractFactory(Config.claimer);
    const claimer = await claimerFactory.attach(Config.networks[activeNetwork].addresses.claimer);
    const Pair = await ethers.getContractFactory("Pair");
    const accounts = await ethers.getSigners();
    const admin = accounts[0].address;
    const marketing = accounts[1].address;
    const buyback = accounts[2];
    const sniping = accounts[3];
    console.log(token.address);
    const contractBalance = await ethers.provider.getBalance(token.address);
    console.log(ethers.utils.formatEther(contractBalance));
    
    //deploy token
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

    //Set contract addresses
    //await setContractAddresses();

    //Burn
    await burn();

    //Move to marketing
    await moveToMarketing();

    //Add liquidity
    await addLiquidity();

    await enableTrading();

    await snipe("0.0085");
    await sell();
    await snipe("0.0085");
    await sell();
    await snipe("0.0085");
    await sell();
    await snipe("0.01");
    await snipe("0.01");
    await sell();
    await snipe("0.0125");
    await snipe("0.0125");
    await sell();
    await snipe("0.0150");
    await snipe("0.0150");
    await sell();

    await claim();

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

    async function enableTrading() {
        const result = await token.enableTrading();
        console.log(result);
    }

    async function setContractAddresses() {
      await token.migrateRouter(Config.networks[activeNetwork].addresses.router);
      await token.setClaimerAddress(claimer.address);
      await token.setBuybackAddress(buyback.address);
      await claimer.migrateRouter(Config.networks[activeNetwork].addresses.router);
      await claimer.setTokenAddress(token.address);
      await claimer.setPayoutTokenAddress(Config.networks[activeNetwork].addresses.BUSD);
      console.log(`Contract addresses set`);
    }

    async function snipe(amount:string) {
      const amountIn = ethers.utils.parseEther(amount);
      //const snipingRouter = router.connect(sniping);
      console.log(sniping.address);
      const result = await router.connect(sniping).swapExactETHForTokensSupportingFeeOnTransferTokens(
          0,
          [Config.networks[activeNetwork].addresses.WBNB, token.address],
          sniping.address,
          Math.floor(Date.now() / 1000) + 60 * 10,
          {value: amountIn} //Buy-in amount
      );
      //console.log(result);
    }

    async function sell() {
      const tokensHeldBN = await token.balanceOf(sniping.address);
      const tokensHeld = ethers.BigNumber.from(tokensHeldBN.toString()).div(10**9);
      const percentToSell = 10;
      const sellAmount = tokensHeldBN.mul(percentToSell).div(100);
      await token.connect(sniping).approve(router.address, tokensHeldBN);
      //   swapExactTokensForETHSupportingFeeOnTransferTokens(
      //     uint amountIn,
      //     uint amountOutMin,
      //     address[] calldata path,
      //     address to,
      //     uint deadline
      // )
      console.log(sellAmount.toString());
      const result = await router.connect(sniping).swapExactTokensForETHSupportingFeeOnTransferTokens(
          sellAmount,
          0,
          [token.address, Config.networks[activeNetwork].addresses.WBNB],
          sniping.address,
          Math.floor(Date.now() / 1000) + 60 * 10
      );
      //console.log(result);
    }

    async function claim() {
      try {
        const tx = await token.connect(sniping).claimBUSD(sniping.address);
        const result = await tx.wait();
        if(result.status == 1)
          console.log(`Claim successful`);
      } catch (error) {
        console.log(error);
      }
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