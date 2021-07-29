import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';
import * as fs from "fs";
import config from "../scripts/config.json";
import { Config } from '../scripts/types/Config';
import { Networks } from "../scripts/enums/Networks";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  var activeNetwork: Networks = Networks[hre.network.name];
  var configFile = fs.readFileSync("./scripts/config.json", "utf-8");
  var config: Config = JSON.parse(configFile);
  const {deployments, getNamedAccounts} = hre;
  const {deploy} = deployments;

  const {deployer} = await getNamedAccounts();

  var claimer = await deploy(config.claimer, {
    from: deployer,
    //gasPrice:4000000,
    args: [],
    log: true,
  });
  config.networks[activeNetwork].addresses.claimer = claimer.address;
  fs.writeFileSync("./scripts/config.json", JSON.stringify(config, null, 4));
};
export default func;
func.tags = [config.claimer];
