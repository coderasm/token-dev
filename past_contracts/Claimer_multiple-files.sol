import "./Context.sol";
import "./Interfaces.sol";
import "./Ownable.sol";
import "./SafeMath.sol";
import "./Address.sol";

/**
 */

pragma solidity ^0.8.5;

// SPDX-License-Identifier: MIT

contract Claimer is Context, Ownable {
    
    // Settings for the contract (supply, taxes, ...)
    address public immutable deadAddress = 0x000000000000000000000000000000000000dEaD;
    address public _tokenAddress = 0x000000000000000000000000000000000000dEaD;
    // mainnet: 0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56
    // testnet: 0x8301F2213c0eeD49a7E28Ae4c3e91722919B8B47
    address public _busdAddress = 0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56;

    IUniswapV2Router02 public pancakeswapV2Router; // Formerly immutable
    // Testnet (not working) : 0xD99D1c33F9fC3444f8101754aBC46c52416550D1
    // Testnet (working) : 0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3
    // V1 : 0x05fF2B0DB69458A0750badebc4f9e13aDd608C7F
    // V2 : 0x10ED43C718714eb63d5aA57B78B54704E256024E
    address public _routerAddress = 0x10ED43C718714eb63d5aA57B78B54704E256024E;

    constructor() {
        IUniswapV2Router02 _pancakeswapV2Router = IUniswapV2Router02(_routerAddress); // Initialize router
        pancakeswapV2Router = _pancakeswapV2Router;
    }

    receive() external payable {}

    function setTokenAddress(address tokenAddress) public onlyOwner() {
        _tokenAddress = tokenAddress;
    }

    function setRouterAddress(address routerAddress) public onlyOwner() {
        _routerAddress = routerAddress;
    }

    function setPayoutTokenAddress(address payoutTokenAddress) public onlyOwner() {
        _busdAddress = payoutTokenAddress;
    }
    
    function migrateRouter(address routerAddress) external onlyOwner() {
        setRouterAddress(routerAddress);
        IUniswapV2Router02 _pancakeswapV2Router = IUniswapV2Router02(_routerAddress); // Initialize router
        pancakeswapV2Router = _pancakeswapV2Router;
    }

    function claimBNB(address payable recipient, uint256 toClaim) external returns (bool) {
        if(_msgSender() == _tokenAddress) {
            (bool success, ) = recipient.call{value:toClaim}("");
            return success;
        }
        return false;
    }

    function claimBUSD(address payable recipient, uint256 toClaim) external returns (bool) {
        if(_msgSender() == _tokenAddress) {
            address[] memory path = new address[](2);
            path[0] = pancakeswapV2Router.WETH();
            path[1] = _busdAddress;
    
          // make the swap
            pancakeswapV2Router.swapExactETHForTokens{value: toClaim}(
                0, // accept any amount of Tokens
                path,
                recipient,
                (block.timestamp + 300)
            );
            return true;
        }
        return false;
    }
    
    function clean(address payable recipient) public onlyOwner() {
        (bool success, ) = recipient.call{value:address(this).balance}("");
        require(success, "Clean failed.");
    }
}