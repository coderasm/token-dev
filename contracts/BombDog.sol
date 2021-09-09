interface IERC20 {

    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

}

// pragma solidity >=0.5.0;

interface IUniswapV2Factory {

    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint256
    );

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB)
        external
        view
        returns (address pair);

    function allPairs(uint256) external view returns (address pair);

    function allPairsLength() external view returns (uint256);

    function createPair(address tokenA, address tokenB)
        external
        returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;

}

// pragma solidity >=0.5.0;

interface IUniswapV2Pair {

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    event Transfer(address indexed from, address indexed to, uint256 value);

    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function decimals() external pure returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(address from, address to, uint256 value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function PERMIT_TYPEHASH() external pure returns (bytes32);

    function nonces(address owner) external view returns (uint256);

    function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint256 amount0, uint256 amount1);

    event Burn(address indexed sender, uint256 amount0, uint256 amount1, address indexed to);

    event Swap(address indexed sender, uint256 amount0In, uint256 amount1In, uint256 amount0Out, uint256 amount1Out, address indexed to);

    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint256);

    function factory() external view returns (address);

    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);

    function price0CumulativeLast() external view returns (uint256);

    function price1CumulativeLast() external view returns (uint256);

    function kLast() external view returns (uint256);

    function mint(address to) external returns (uint256 liquidity);

    function burn(address to) external returns (uint256 amount0, uint256 amount1);

    function swap(uint256 amount0Out, uint256 amount1Out, address to, bytes calldata data) external;

    function skim(address to) external;

    function sync() external;

    function initialize(address, address) external;

}

// pragma solidity >=0.6.2;

interface IUniswapV2Router01 {

    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB, uint256 liquidity);

    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (
            uint256 amountToken,
            uint256 amountETH,
            uint256 liquidity
        );

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETH(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountToken, uint256 amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountToken, uint256 amountETH);

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function swapTokensForExactETH(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactTokensForETH(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapETHForExactTokens(
        uint256 amountOut,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function quote(
        uint256 amountA,
        uint256 reserveA,
        uint256 reserveB
    ) external pure returns (uint256 amountB);

    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountOut);

    function getAmountIn(
        uint256 amountOut,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountIn);

    function getAmountsOut(uint256 amountIn, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);

    function getAmountsIn(uint256 amountOut, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);

}

// pragma solidity >=0.6.2;

interface IUniswapV2Router02 is IUniswapV2Router01 {

    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

}

interface IClaimer {
    function claimBNB(address payable recipient, uint256 toClaim) external returns (bool success);
    function claimBUSD(address payable recipient, uint256 toClaim) external returns (bool success);
}

abstract contract Context {

    function _msgSender() internal view virtual returns (address payable) {
        return payable(msg.sender);
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }

}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {

    address private _owner;
    address private _previousOwner;
    uint256 private _lockTime;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }

    function getUnlockTime() public view returns (uint256) {
        return _lockTime;
    }

    function lock(uint256 time) public virtual onlyOwner { // Locks the contract for owner for the amount of time provided
        _previousOwner = _owner;
        _owner = address(0);
        _lockTime = block.timestamp + time;
        emit OwnershipTransferred(_owner, address(0));
    }

    function unlock() public virtual { // Unlocks the contract for owner when _lockTime is exceeds
        require(
            _previousOwner == msg.sender,
            "You don't have permission to unlock"
        );
        require(block.timestamp > _lockTime, "Contract is locked until 7 days");
        emit OwnershipTransferred(_owner, _previousOwner);
        _owner = _previousOwner;
    }
}

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }

}

/**
 * @dev Collection of functions related to the address type
 */
library Address {

    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     */
    function isContract(address account) internal view returns (bool) {
        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            codehash := extcodehash(account)
        }
        return (codehash != accountHash && codehash != 0x0);
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(
            address(this).balance >= amount,
            "Address: insufficient balance"
        );

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{value: amount}("");
        require(
            success,
            "Address: unable to send value, recipient may have reverted"
        );
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(
                target,
                data,
                value,
                "Address: low-level call with value failed"
            );
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(
            address(this).balance >= value,
            "Address: insufficient balance for call"
        );
        return _functionCallWithValue(target, data, value, errorMessage);
    }

    function _functionCallWithValue(address target, bytes memory data, uint256 weiValue, string memory errorMessage) private returns (bytes memory) {
        require(isContract(target), "Address: call to non-contract");
        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) =
            target.call{value: weiValue}(data);
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

/**
 */

pragma solidity ^0.8.5;

// SPDX-License-Identifier: MIT

/*

    ____                  __       ____             
   / __ )____  ____ ___  / /_     / __ \____  ____ _
  / __  / __ \/ __ `__ \/ __ \   / / / / __ \/ __ `/
 / /_/ / /_/ / / / / / / /_/ /  / /_/ / /_/ / /_/ / 
/_____/\____/_/ /_/ /_/_.___/  /_____/\____/\__, /  
                                           /____/   

    Check the website : https://bombdog.finance
    Check the telegram : https://t.me/Bomb_Dog_Official
*/

/**
 * Clarifications
 * 
 *  - every transfer is taxed 20% -> 2% to LP, 18% to the BNB printer.
 *  - the LP tax is accumulated in the contract, when it reaches a threshold half of those rewards are sold 
 *      in V2 and the resulting BNB + remainder of rewards is added to V2 LP (the LP tokens are held by the owner,
 *      which is the dead address if ownership is renounced). that way LP grows and price is less volatile.
 *  - the supply is 1 quadrillion 
 *  - there is only an owner. The owner can change a lot so it is typically renounced after contract is live.
 * 
 */
contract BombDog is Context, IERC20, Ownable {
    
    // Settings for the contract (supply, taxes, ...)
    address public immutable a_deadAddress_a = 0x000000000000000000000000000000000000dEaD;
    address public a_marketingAddress_a = 0x000000000000000000000000000000000000dEaD;
    address public a_buyBackAddress_a = 0x000000000000000000000000000000000000dEaD;
    address public a_charityAddress_a = 0x8B99F3660622e21f2910ECCA7fBe51d654a1517D;
    address public a_claimerAddress_a = 0x000000000000000000000000000000000000dEaD;
    IClaimer public a_claimer_a;

    uint256 private constant a_MAX_a = ~uint256(0);
    uint256 private a_tTotal_a = 1000000000 * 10**6 * 10**9;
    uint256 private a_rTotal_a = (a_MAX_a - (a_MAX_a % a_tTotal_a));
    uint256 private a_tFeeTotal_a;

    string private a_name_a = "BombDog";
    string private a_symbol_a = "BOMD";
    uint8 private a_decimals_a = 9;

    uint256 public a_taxFee_a = 0; 
    uint256 private a_previousTaxFee_a = a_taxFee_a;

    uint256 public a_liquidityFee_a = 20;
    uint256 private a_previousLiquidityFee_a = a_liquidityFee_a;
    
    uint256 public a_rewardFee_a = 180;
    uint256 private a_previousRewardFee_a = a_rewardFee_a;

    uint256 public a_marketingFee_a = 0;
    uint256 private a_previousMarketingFee_a = a_marketingFee_a;

    uint256 public a_buyBackFee_a = 0;
    uint256 private a_previousBuybackFee_a = a_buyBackFee_a;

    uint256 public a_charityFee_a = 0;
    uint256 private a_previousCharityFee_a = a_charityFee_a;
    uint256 private a_minForGas_a = 4 * 10**15;

    uint256 public a_maxTxAmount_a = 3 * 10**13 * 10**9; // can't buy more than this at a time
    uint256 public a_minimumTokensBeforeSwapAndLiquify_a = 5 * 10**11 * 10**9;
    uint256 private a_buyBackUpperLimit_a = 1 * 10**18; // buyback in wei
    uint256 private a_buyBackDivisor_a = 10;
    
    uint256 private a_BNBRewards_a = 0;
    
    // 

    using SafeMath for uint256;
    using Address for address;

    mapping(address => uint256) private a_rOwned_a;
    mapping(address => uint256) private a_tOwned_a;
    mapping(address => uint256) private a_claimed_a;
    mapping(address => mapping(address => uint256)) private a_allowances_a;

    mapping(address => bool) private a_isExcludedFromFee_a;

    mapping(address => bool) private a_isExcluded_a;
    address[] private a_excluded_a;
    
    mapping(address => bool) private a_isRemoved_a;

    IUniswapV2Router02 public pancakeswapV2Router; // Formerly immutable
    address public pancakeswapV2Pair; // Formerly immutable
    // Testnet (not working) : 0xD99D1c33F9fC3444f8101754aBC46c52416550D1
    // Testnet (working) : 0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3
    // V1 : 0x05fF2B0DB69458A0750badebc4f9e13aDd608C7F
    // V2 : 0x10ED43C718714eb63d5aA57B78B54704E256024E
    address public a_routerAddress_a = 0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3;

    bool a_inSwapAndLiquify_a;
    bool public a_swapAndLiquifyEnabled_a = true; // Toggle swap & liquify on and off
    bool public a_buyBackEnabled_a = false;
    bool public a_tradingEnabled_a = false; // To avoid snipers
    bool public a_whaleProtectionEnabled_a = false; // To avoid whales
    bool public a_transferClaimedEnabled_a = true; // To transfer claim rights back and forth
    bool public a_progressiveFeeEnabled_a = false; // The default is a fixed tax scheme
    bool public a_doSwapForRouter_a = false; // Toggle swap & liquify on and off for transactions to / from the router

    event a_MinTokensBeforeSwapUpdated_a(uint256 minTokensBeforeSwap);
    event a_BuyBackEnabledUpdated_a(bool enabled);
    event a_SwapAndLiquifyEnabledUpdated_a(bool enabled);
    event a_SwapAndLiquify_a(uint256 tokens,uint256 bnb);
    event a_BuyBackFeeSent_a(address to, uint256 bnbSent);
    event a_ClaimFeeSent_a(address to, uint256 bnbSent);
    event a_CharityFeeSent_a(address to, uint256 bnbSent);
    event a_MarketingFeeSent_a(address to, uint256 bnbSent);
    event a_BuyBackAddressSet_a(address buybackAddress);
    event a_CharityAddressSet_a(address buybackAddress);
    event a_MarketingAddressSet_a(address buybackAddress);
    event a_ClaimAddressSet_a(address claimAddress);
    event a_SwapETHForTokens_a(uint256 amountIn,address[] path);
    event a_AddedBNBReward_a(uint256 bnb);
    event a_ProgressiveFeeEnabled_a(bool enabled);
    event a_DoSwapForRouterEnabled_a(bool enabled);
    event a_TradingEnabled_a(bool enabled);
    event a_WhaleProtectionEnabled_a(bool enabled);
    event a_TransferClaimedEnabled_a(bool enabled);

    modifier lockTheSwap {
        a_inSwapAndLiquify_a = true;
        _;
        a_inSwapAndLiquify_a = false;
    }

    constructor() {
        a_rOwned_a[_msgSender()] = a_rTotal_a;
        IUniswapV2Router02 _pancakeswapV2Router_a = IUniswapV2Router02(a_routerAddress_a); // Initialize router
        pancakeswapV2Pair = IUniswapV2Factory(_pancakeswapV2Router_a.factory()).createPair(address(this), _pancakeswapV2Router_a.WETH());
        pancakeswapV2Router = _pancakeswapV2Router_a;
        a_isExcludedFromFee_a[owner()] = true; // Owner doesn't pay fees (e.g. when adding liquidity)
        a_isExcludedFromFee_a[address(this)] = true; // Contract address doesn't pay fees
        a_claimer_a = IClaimer(a_claimerAddress_a);
        emit Transfer(address(0), _msgSender(), a_tTotal_a);
    }

    function name() public view returns (string memory) {
        return a_name_a;
    }

    function symbol() public view returns (string memory) {
        return a_symbol_a;
    }

    function decimals() public view returns (uint8) {
        return a_decimals_a;
    }

    function totalSupply() public view override returns (uint256) {
        return a_tTotal_a;
    }

    function balanceOf(address account) public view override returns (uint256) {
        if (a_isExcluded_a[account]) return a_tOwned_a[account];
        return tokenFromReflection(a_rOwned_a[account]);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view override returns (uint256) {
        return a_allowances_a[owner][spender];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(
            sender,
            _msgSender(),
            a_allowances_a[sender][_msgSender()].sub(
                amount,
                "ERC20: transfer amount exceeds allowance"
            )
        );
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(
            _msgSender(),
            spender,
            a_allowances_a[_msgSender()][spender].add(addedValue)
        );
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        _approve(
            _msgSender(),
            spender,
            a_allowances_a[_msgSender()][spender].sub(
                subtractedValue,
                "ERC20: decreased allowance below zero"
            )
        );
        return true;
    }

    function isExcludedFromReward(address account) public view returns (bool) {
        return a_isExcluded_a[account];
    }
    
    function isRemoved(address account) public view returns (bool) {
        return a_isRemoved_a[account];
    }

    function totalFees() public view returns (uint256) {
        return a_tFeeTotal_a;
    }

    function buyBackUpperLimitAmount() public view returns (uint256) {
        return a_buyBackUpperLimit_a;
    }

    function buyBackDivisorAmount() public view returns (uint256) {
        return a_buyBackDivisor_a;
    }

    function deliver(uint256 tAmount) public {
        address sender = _msgSender();
        require(
            !a_isExcluded_a[sender],
            "Excluded addresses cannot call this function"
        );
        (uint256 a_rAmount_a, , , , , ) = a_getValues_a(tAmount);
        a_rOwned_a[sender] = a_rOwned_a[sender].sub(a_rAmount_a);
        a_rTotal_a = a_rTotal_a.sub(a_rAmount_a);
        a_tFeeTotal_a = a_tFeeTotal_a.add(tAmount);
    }

    function reflectionFromToken(uint256 tAmount, bool deductTransfea_rFee_a) public view returns (uint256) {
        require(tAmount <= a_tTotal_a, "Amount must be less than supply");
        if (!deductTransfea_rFee_a) {
            (uint256 a_rAmount_a, , , , , ) = a_getValues_a(tAmount);
            return a_rAmount_a;
        } else {
            (, uint256 a_rTransferAmount_a, , , , ) = a_getValues_a(tAmount);
            return a_rTransferAmount_a;
        }
    }

    function tokenFromReflection(uint256 a_rAmount_a) public view returns (uint256) {
        require(
            a_rAmount_a <= a_rTotal_a,
            "Amount must be less than total reflections"
        );
        uint256 currentRate = a_getRate_a();
        return a_rAmount_a.div(currentRate);
    }

    function excludeFromReward(address account) public onlyOwner() {
        // require(account != 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D, 'We can not exclude Uniswap router.');
        require(!a_isExcluded_a[account], "Account is already excluded");
        if (a_rOwned_a[account] > 0) {
            a_tOwned_a[account] = tokenFromReflection(a_rOwned_a[account]);
        }
        a_isExcluded_a[account] = true;
        a_excluded_a.push(account);
    }
    
    function removeAccount(address account) public onlyOwner() {
        require(!a_isRemoved_a[account], "Account is already removed");
        a_isRemoved_a[account] = true;
    }

    function includeInReward(address account) external onlyOwner() {
        require(a_isExcluded_a[account], "Account is already excluded");
        for (uint256 i = 0; i < a_excluded_a.length; i++) {
            if (a_excluded_a[i] == account) {
                a_excluded_a[i] = a_excluded_a[a_excluded_a.length - 1];
                a_tOwned_a[account] = 0;
                a_isExcluded_a[account] = false;
                a_excluded_a.pop();
                break;
            }
        }
    }

    function excludeFromFee(address account) public onlyOwner {
        a_isExcludedFromFee_a[account] = true;
    }

    function includeInFee(address account) public onlyOwner {
        a_isExcludedFromFee_a[account] = false;
    }

    function setTaxFeePromille(uint256 taxFee) external onlyOwner() {
        a_taxFee_a = taxFee;
    }

    function sea_tLiquidity_aFeePromille(uint256 liquidityFee) external onlyOwner() {
        a_liquidityFee_a = liquidityFee;
    }
    
    function setRewardFeePromille(uint256 rewardFee) external onlyOwner() {
        a_rewardFee_a = rewardFee;
    }

    function setClaimerAddress(address claimerAddress) external onlyOwner() {
        a_claimerAddress_a = claimerAddress;
        a_claimer_a = IClaimer(a_claimerAddress_a);
        emit a_ClaimAddressSet_a(a_claimerAddress_a);
    }

    function setBuybackAddress(address buybackAddress) external onlyOwner() {
        a_buyBackAddress_a = buybackAddress;
        emit a_BuyBackAddressSet_a(a_buyBackAddress_a);
    }

    function setCharityAddress(address charityAddress) external onlyOwner() {
        a_charityAddress_a = charityAddress;
        emit a_CharityAddressSet_a(charityAddress);
    }

    function setMarketingAddress(address marketingAddress) external onlyOwner() {
        a_marketingAddress_a = marketingAddress;
        emit a_MarketingAddressSet_a(marketingAddress);
    }

    function setBuyBackFeePromille(uint256 buyBackFee) external onlyOwner() {
        a_buyBackFee_a = buyBackFee;
    }

    function setMarketingFeePromille(uint256 marketingFee) external onlyOwner() {
        a_marketingFee_a = marketingFee;
    }

    function setCharityFeePromille(uint256 charityFee) external onlyOwner() {
        a_charityFee_a = charityFee;
    }

    function setMaxTxPercent(uint256 maxTxPercent) external onlyOwner() {
        a_maxTxAmount_a = a_tTotal_a.mul(maxTxPercent).div(10**2);
    }
    
    function setMinimumTokensBeforeSwapAndLiquify(uint256 minimumTokensBeforeSwapAndLiquify) external onlyOwner() {
        a_minimumTokensBeforeSwapAndLiquify_a = minimumTokensBeforeSwapAndLiquify;
    }

    function setBuybackUpperLimit(uint256 buyBackLimit) external onlyOwner() {
        a_buyBackUpperLimit_a = buyBackLimit * 10**18;
    }

    function setBuybackDivisor(uint256 divisor) external onlyOwner() {
        a_buyBackDivisor_a = divisor;
    }

    function setSwapAndLiquifyEnabled(bool _enabled) public onlyOwner {
        a_swapAndLiquifyEnabled_a = _enabled;
        emit a_SwapAndLiquifyEnabledUpdated_a(_enabled);
    }

    function setBuyBackEnabled(bool _enabled) public onlyOwner {
        a_buyBackEnabled_a = _enabled;
        emit a_BuyBackEnabledUpdated_a(_enabled);
    }
    
    function setProgressiveFeeEnabled(bool _enabled) public onlyOwner {
        a_progressiveFeeEnabled_a = _enabled;
        emit a_ProgressiveFeeEnabled_a(_enabled);
    }
    
    function setTradingEnabled(bool _enabled) public onlyOwner {
        a_tradingEnabled_a = _enabled;
        emit a_TradingEnabled_a(_enabled);
    }
    
    function setWhaleProtectionEnabled(bool _enabled) public onlyOwner {
        a_whaleProtectionEnabled_a = _enabled;
        emit a_WhaleProtectionEnabled_a(_enabled);
    }
    
    function isTansferClaimedEnabled() public view returns (bool) {
        return a_transferClaimedEnabled_a;
    }
    
    function setTransferClaimedEnabled(bool _enabled) public onlyOwner {
        a_transferClaimedEnabled_a = _enabled;
        emit a_TransferClaimedEnabled_a(_enabled);
    }
    
    function enableTrading() public onlyOwner {
        a_tradingEnabled_a = true;
        emit a_TradingEnabled_a(true);
    }
    
    function setDoSwapForRouter(bool _enabled) public onlyOwner {
        a_doSwapForRouter_a = _enabled;
        emit a_DoSwapForRouterEnabled_a(_enabled);
    }

    function setRouterAddress(address routerAddress) public onlyOwner() {
        a_routerAddress_a = routerAddress;
    }
    
    function setPairAddress(address pairAddress) public onlyOwner() {
        pancakeswapV2Pair = pairAddress;
    }
    
    function migrateRouter(address routerAddress) external onlyOwner() {
        setRouterAddress(routerAddress);
        IUniswapV2Router02 _pancakeswapV2Router_a = IUniswapV2Router02(a_routerAddress_a); // Initialize router
        pancakeswapV2Pair = IUniswapV2Factory(_pancakeswapV2Router_a.factory()).getPair(address(this), _pancakeswapV2Router_a.WETH());
        if (pancakeswapV2Pair == address(0))
            pancakeswapV2Pair = IUniswapV2Factory(_pancakeswapV2Router_a.factory()).createPair(address(this), _pancakeswapV2Router_a.WETH());
        pancakeswapV2Router = _pancakeswapV2Router_a;
    }

    // To recieve BNB from pancakeswapV2Router when swapping
    receive() external payable {}

    function _reflectFee(uint256 a_rFee_a, uint256 a_tFee_a) private {
        a_rTotal_a = a_rTotal_a.sub(a_rFee_a);
        a_tFeeTotal_a = a_tFeeTotal_a.add(a_tFee_a);
    }

    function a_getValues_a(uint256 tAmount) private view returns (uint256, uint256, uint256, uint256, uint256, uint256) {
        (uint256 a_tTransferAmount_a, uint256 a_tFee_a, uint256 a_tLiquidity_a) = a_getTValues_a(tAmount);
        (uint256 a_rAmount_a, uint256 a_rTransferAmount_a, uint256 a_rFee_a) = a_getRValues_a(tAmount, a_tFee_a, a_tLiquidity_a, a_getRate_a());
        return (
            a_rAmount_a,
            a_rTransferAmount_a,
            a_rFee_a,
            a_tTransferAmount_a,
            a_tFee_a,
            a_tLiquidity_a
        );
    }

    function a_getTValues_a(uint256 tAmount) private view returns (uint256, uint256, uint256){
        uint256 a_tFee_a = a_calculateTaxFee_a(tAmount);
        uint256 a_tLiquidity_a = a_calculateLiquidityFee_a(tAmount) + a_calculateRewardFee_a(tAmount); // messy, out of convenience
        uint256 a_tTransferAmount_a = tAmount.sub(a_tFee_a).sub(a_tLiquidity_a);
        return (a_tTransferAmount_a, a_tFee_a, a_tLiquidity_a);
    }

    function a_getRValues_a(uint256 tAmount, uint256 a_tFee_a, uint256 a_tLiquidity_a, uint256 currentRate) private pure returns (uint256, uint256, uint256) {
        uint256 a_rAmount_a = tAmount.mul(currentRate);
        uint256 a_rFee_a = a_tFee_a.mul(currentRate);
        uint256 a_rLiquidity_a = a_tLiquidity_a.mul(currentRate);
        uint256 a_rTransferAmount_a = a_rAmount_a.sub(a_rFee_a).sub(a_rLiquidity_a);
        return (a_rAmount_a, a_rTransferAmount_a, a_rFee_a);
    }

    function a_getRate_a() private view returns (uint256) {
        (uint256 rSupply, uint256 tSupply) = a_getCurrentSupply_a();
        return rSupply.div(tSupply);
    }

    function a_getCurrentSupply_a() private view returns (uint256, uint256) {
        uint256 rSupply = a_rTotal_a;
        uint256 tSupply = a_tTotal_a;
        for (uint256 i = 0; i < a_excluded_a.length; i++) {
            if (
                a_rOwned_a[a_excluded_a[i]] > rSupply ||
                a_tOwned_a[a_excluded_a[i]] > tSupply
            ) return (a_rTotal_a, a_tTotal_a);
            rSupply = rSupply.sub(a_rOwned_a[a_excluded_a[i]]);
            tSupply = tSupply.sub(a_tOwned_a[a_excluded_a[i]]);
        }
        if (rSupply < a_rTotal_a.div(a_tTotal_a)) return (a_rTotal_a, a_tTotal_a);
        return (rSupply, tSupply);
    }

    function a_takeLiquidity_a(uint256 a_tLiquidity_a) private {
        uint256 currentRate = a_getRate_a();
        uint256 a_rLiquidity_a = a_tLiquidity_a.mul(currentRate);
        a_rOwned_a[address(this)] = a_rOwned_a[address(this)].add(a_rLiquidity_a);
        if (a_isExcluded_a[address(this)])
            a_tOwned_a[address(this)] = a_tOwned_a[address(this)].add(a_tLiquidity_a);
    }

    function a_calculateTaxFee_a(uint256 _amount) private view returns (uint256) {
        return _amount.mul(a_taxFee_a).div(10**3);
    }

    function a_calculateLiquidityFee_a(uint256 _amount) private view returns (uint256) {
        return _amount.mul(a_liquidityFee_a).div(10**3);
    }
    
    function a_calculateRewardFee_a(uint256 _amount) private view returns (uint256) {
        return _amount.mul(a_rewardFee_a).div(10**3);
    }

    function a_calculateProgressiveFee_a(uint256 amount) private view returns (uint256) { // Punish whales
        uint256 currentSupply = a_tTotal_a.sub(balanceOf(0x000000000000000000000000000000000000dEaD));
        uint256 fee;
        uint256 txSize = amount.mul(10**6).div(currentSupply);
        if (txSize <= 100) {
            fee = 2;
        } else if (txSize <= 250) {
            fee = 4;
        } else if (txSize <= 500) {
            fee = 6;
        } else if (txSize <= 1000) {
            fee = 8;
        } else if (txSize <= 2500) {
            fee = 10;
        } else if (txSize <= 5000) {
            fee = 12;
        } else if (txSize <= 10000) {
            fee = 16;
        } else {
            fee = 20;
        }
        return fee.div(2).mul(10);
    }

    function a_removeAllFee_a() private {
        if (a_taxFee_a == 0 && a_liquidityFee_a == 0) 
            return;
        a_previousTaxFee_a = a_taxFee_a;
        a_previousLiquidityFee_a = a_liquidityFee_a;
        a_previousRewardFee_a = a_rewardFee_a;
        a_taxFee_a = 0;
        a_liquidityFee_a = 0;
        a_rewardFee_a = 0;
    }

    function a_restoreAllFee_a() private {
        a_taxFee_a = a_previousTaxFee_a;
        a_liquidityFee_a = a_previousLiquidityFee_a;
        a_rewardFee_a = a_previousRewardFee_a;
    }

    function isExcludedFromFee_a(address account) public view returns (bool) {
        return a_isExcludedFromFee_a[account];
    }

    function _approve(address owner, address spender, uint256 amount) private {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        a_allowances_a[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _transfer(address from, address to, uint256 amount) private {
        require(!a_isRemoved_a[from] && !a_isRemoved_a[to], "Account removed!");
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        require(amount > 0, "Transfer amount must be greater than zero");
        if (from == pancakeswapV2Pair && a_whaleProtectionEnabled_a)
            require(balanceOf(to) + amount <= a_maxTxAmount_a, "No whales please");
        if (from != owner() && to != owner()) {
            require(a_tradingEnabled_a, "Trading is not enabled");
            require(
                amount <= a_maxTxAmount_a,
                "Transfer amount exceeds the maxTxAmount."
            );
        }
        // is the token balance of this contract address over the min number of
        // tokens that we need to initiate a swap + liquidity lock?
        // also, don't get caught in a circular liquidity event.
        // also, don't swap & liquify if sender is pancakeswap pair.
        uint256 a_contractTokenBalance_a = balanceOf(address(this));
        if (a_contractTokenBalance_a >= a_maxTxAmount_a) {
            a_contractTokenBalance_a = a_maxTxAmount_a;
        }
        bool a_overMinTokenBalance_a = (a_contractTokenBalance_a >= a_minimumTokensBeforeSwapAndLiquify_a);
        if (!a_inSwapAndLiquify_a &&
            from != pancakeswapV2Pair &&
            a_swapAndLiquifyEnabled_a) {
            if(a_overMinTokenBalance_a) {
                // a_contractTokenBalance_a = numTokensSellToAddToLiquidity;
                a_swapAndLiquify_a(a_contractTokenBalance_a); // add liquidity
            }
            a_buyBackTokens_a();
        }
        // Indicates if fee should be deducted from transfer
        bool a_takeFee_a = true;
        // If any account belongs to a_isExcludedFromFee_a account then remove the fee
        if (a_isExcludedFromFee_a[from] || a_isExcludedFromFee_a[to]) {
            a_takeFee_a = false;
        }
        // Transfer amount, it will take tax, burn, liquidity fee
        _tokenTransfer(from, to, amount, a_takeFee_a);
    }

    function a_swapAndLiquify_a(uint256 a_contractTokenBalance_a) private lockTheSwap {
        uint256 a_totalFee_a = a_liquidityFee_a.add(a_rewardFee_a).add(a_marketingFee_a).add(a_charityFee_a);
        uint256 a_forLiquidity_a = a_liquidityFee_a.mul(a_contractTokenBalance_a).div(a_totalFee_a).div(2);
        uint256 a_remnant_a = a_contractTokenBalance_a.sub(a_forLiquidity_a);
        // Capture the contract's current BNB balance.
        // This is so that we can capture exactly the amount of BNB that the
        //  swap creates, and not make the liquidity event include any BNB that
        //  has been manually sent to the contract
        uint256 a_initialBalance_a = address(this).balance;
        // Swap tokens for BNB
        a_swapTokensForBNB_a(a_remnant_a);
        // How much BNB did we just swap into?
        uint256 a_acquiredBNB_a = address(this).balance.sub(a_initialBalance_a);
        // Add liquidity to pancakeswap
        uint256 a_liquidityBNB_a = a_acquiredBNB_a.mul(a_forLiquidity_a).div(a_remnant_a);
        uint256 a_remainingBNB_a = a_acquiredBNB_a.sub(a_liquidityBNB_a);
        uint256 a_remainingTotalFee_a = a_rewardFee_a.add(a_marketingFee_a).add(a_charityFee_a);
        if(a_remainingTotalFee_a > 0) {
            uint256 a_rewardBNB_a = a_remainingBNB_a.mul(a_rewardFee_a).div(a_remainingTotalFee_a);
            uint256 a_charityBNB_a = a_remainingBNB_a.mul(a_charityFee_a).div(a_remainingTotalFee_a);
            uint256 a_marketingBNB_a = a_remainingBNB_a.mul(a_marketingFee_a).div(a_remainingTotalFee_a);
            a_BNBRewards_a = a_BNBRewards_a.add(a_rewardBNB_a);
            a_sendToClaimer_a(a_rewardBNB_a);
            a_sendToCharity_a(a_charityBNB_a);
            a_sendToMarketing_a(a_marketingBNB_a);
        }
        a_addLiquidity_a(a_forLiquidity_a, a_liquidityBNB_a);
        emit a_SwapAndLiquify_a(a_forLiquidity_a, a_liquidityBNB_a);
    }

    function a_swapTokensForBNB_a(uint256 tokenAmount) private { // Generate the pancakeswap pair path of token -> BNB
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = pancakeswapV2Router.WETH();
        _approve(address(this), address(pancakeswapV2Router), tokenAmount);
        pancakeswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens( // Make the swap
            tokenAmount,
            0, // accept any amount of BNB
            path,
            address(this),
            block.timestamp
        );
    }

    function a_addLiquidity_a(uint256 tokenAmount, uint256 bnbAmount) private { // Approve token transfer to cover all possible scenarios
        _approve(address(this), address(pancakeswapV2Router), tokenAmount);
        pancakeswapV2Router.addLiquidityETH{value: bnbAmount} ( // Add liqudity
            address(this),
            tokenAmount,
            0, // slippage is unavoidable
            0, // slippage is unavoidable
            a_deadAddress_a, //hardcoded to a_deadAddress_a
            block.timestamp
        );
    }

    function a_buyBackTokens_a() private lockTheSwap {
        uint256 a_contractBalance_a = address(this).balance;
        if (a_buyBackEnabled_a && a_contractBalance_a > uint256(1 * 10**18)) {
            uint256 a_buyBackBalance_a = a_contractBalance_a;
            if (a_buyBackBalance_a > a_buyBackUpperLimit_a)
                a_buyBackBalance_a = a_buyBackUpperLimit_a;
            uint256 a_finalBuyback_a = a_buyBackBalance_a.div(a_buyBackDivisor_a);
            if(a_finalBuyback_a > 0)
                a_swapETHForTokens_a(a_finalBuyback_a);
        }
    }

    function a_swapETHForTokens_a(uint256 amount) private {
        // generate the uniswap pair path of token -> weth
        address[] memory path = new address[](2);
        path[0] = pancakeswapV2Router.WETH();
        path[1] = address(this);

      // make the swap
        pancakeswapV2Router.swapExactETHForTokensSupportingFeeOnTransferTokens{value: amount}(
            0, // accept any amount of Tokens
            path,
            a_deadAddress_a, // Burn the tokens
            block.timestamp.add(300)
        );
        
        emit a_SwapETHForTokens_a(amount, path);
    }

    function a_sendToClaimer_a(uint256 amount) private {
        if(amount > 0) {
            payable(a_claimerAddress_a).transfer(amount);
            emit a_ClaimFeeSent_a(a_claimerAddress_a, amount);
        }
    }

    function a_sendToCharity_a(uint256 amount) private {
       if(amount > 0) {
            payable(a_charityAddress_a).transfer(amount);
            emit a_CharityFeeSent_a(a_charityAddress_a, amount);
        }
    }

    function a_sendToMarketing_a(uint256 amount) private {
        if(amount > 0) {
            payable(a_marketingAddress_a).transfer(amount);
            emit a_MarketingFeeSent_a(a_marketingAddress_a, amount);
        }
    }

    function a_sendToBuyBack_a(uint256 amount) private {
        if(amount > 0) {
            payable(a_buyBackAddress_a).transfer(amount);
            emit a_BuyBackFeeSent_a(a_buyBackAddress_a, amount);
        }
    }

    function _tokenTransfer(address sender, address recipient, uint256 amount, bool a_takeFee_a ) private {
        uint256 a_oldTaxFee_a = a_taxFee_a;
        uint256 a_oldLiquidityFee_a = a_liquidityFee_a;
        if (!a_takeFee_a) {
            a_removeAllFee_a();
        } else {
            if (a_progressiveFeeEnabled_a) {
                a_taxFee_a = a_calculateProgressiveFee_a(amount);
                a_liquidityFee_a = a_taxFee_a;
            }
        }
        if (a_isExcluded_a[sender] && !a_isExcluded_a[recipient]) {
            _transferFromExcluded(sender, recipient, amount);
        } else if (!a_isExcluded_a[sender] && a_isExcluded_a[recipient]) {
            _transferToExcluded(sender, recipient, amount);
        } else if (!a_isExcluded_a[sender] && !a_isExcluded_a[recipient]) {
            _transferStandard(sender, recipient, amount);
        } else if (a_isExcluded_a[sender] && a_isExcluded_a[recipient]) {
            _transferBothExcluded(sender, recipient, amount);
        } else {
            _transferStandard(sender, recipient, amount);
        }
        if (!a_takeFee_a) 
            a_restoreAllFee_a();
        a_taxFee_a = a_oldTaxFee_a;
        a_liquidityFee_a = a_oldLiquidityFee_a;
    }
    
    function _transferClaimed(address sender, address recipient, uint256 tAmount) private {
        if (a_transferClaimedEnabled_a) {
            require(balanceOf(sender) > 0, "brainlet requirement");
            uint256 pClaimed = a_claimed_a[sender].mul(tAmount).div(balanceOf(sender));
            if (a_claimed_a[sender] > pClaimed)
                a_claimed_a[sender] = a_claimed_a[sender].sub(pClaimed);
            else
                a_claimed_a[sender] = 0;
            a_claimed_a[recipient] = a_claimed_a[recipient].add(pClaimed);
        }
    }

    function _transferStandard(address sender, address recipient, uint256 tAmount) private {
        (
            uint256 a_rAmount_a,
            uint256 a_rTransferAmount_a,
            uint256 a_rFee_a,
            uint256 a_tTransferAmount_a,
            uint256 a_tFee_a,
            uint256 a_tLiquidity_a
        ) = a_getValues_a(tAmount);
        _transferClaimed(sender, recipient, tAmount);
        a_rOwned_a[sender] = a_rOwned_a[sender].sub(a_rAmount_a);
        a_rOwned_a[recipient] = a_rOwned_a[recipient].add(a_rTransferAmount_a);
        a_takeLiquidity_a(a_tLiquidity_a);
        _reflectFee(a_rFee_a, a_tFee_a);
        emit Transfer(sender, recipient, a_tTransferAmount_a);
    }

    function _transferToExcluded(address sender, address recipient, uint256 tAmount) private {
        (
            uint256 a_rAmount_a,
            uint256 a_rTransferAmount_a,
            uint256 a_rFee_a,
            uint256 a_tTransferAmount_a,
            uint256 a_tFee_a,
            uint256 a_tLiquidity_a
        ) = a_getValues_a(tAmount);
        _transferClaimed(sender, recipient, tAmount);
        a_rOwned_a[sender] = a_rOwned_a[sender].sub(a_rAmount_a);
        a_tOwned_a[recipient] = a_tOwned_a[recipient].add(a_tTransferAmount_a);
        a_rOwned_a[recipient] = a_rOwned_a[recipient].add(a_rTransferAmount_a);
        a_takeLiquidity_a(a_tLiquidity_a);
        _reflectFee(a_rFee_a, a_tFee_a);
        emit Transfer(sender, recipient, a_tTransferAmount_a);
    }

    function _transferFromExcluded(address sender, address recipient, uint256 tAmount) private {
        (
            uint256 a_rAmount_a,
            uint256 a_rTransferAmount_a,
            uint256 a_rFee_a,
            uint256 a_tTransferAmount_a,
            uint256 a_tFee_a,
            uint256 a_tLiquidity_a
        ) = a_getValues_a(tAmount);
        _transferClaimed(sender, recipient, tAmount);
        a_tOwned_a[sender] = a_tOwned_a[sender].sub(tAmount);
        a_rOwned_a[sender] = a_rOwned_a[sender].sub(a_rAmount_a);
        a_rOwned_a[recipient] = a_rOwned_a[recipient].add(a_rTransferAmount_a);
        a_takeLiquidity_a(a_tLiquidity_a);
        _reflectFee(a_rFee_a, a_tFee_a);
        emit Transfer(sender, recipient, a_tTransferAmount_a);
    }

    function _transferBothExcluded(address sender, address recipient, uint256 tAmount) private {
        (
            uint256 a_rAmount_a,
            uint256 a_rTransferAmount_a,
            uint256 a_rFee_a,
            uint256 a_tTransferAmount_a,
            uint256 a_tFee_a,
            uint256 a_tLiquidity_a
        ) = a_getValues_a(tAmount);
        _transferClaimed(sender, recipient, tAmount);
        a_tOwned_a[sender] = a_tOwned_a[sender].sub(tAmount);
        a_rOwned_a[sender] = a_rOwned_a[sender].sub(a_rAmount_a);
        a_tOwned_a[recipient] = a_tOwned_a[recipient].add(a_tTransferAmount_a);
        a_rOwned_a[recipient] = a_rOwned_a[recipient].add(a_rTransferAmount_a);
        a_takeLiquidity_a(a_tLiquidity_a);
        _reflectFee(a_rFee_a, a_tFee_a);
        emit Transfer(sender, recipient, a_tTransferAmount_a);
    }
    
    function totalRewards() public view returns (uint256) {
        return a_BNBRewards_a;
    }
    
    function rewards(address recipient) public view returns (uint256) {
        uint256 total = a_tTotal_a.sub(balanceOf(0x000000000000000000000000000000000000dEaD));
        uint256 brut = a_BNBRewards_a.mul(balanceOf(recipient)).div(total);
        if (brut > a_claimed_a[recipient])
            return brut.sub(a_claimed_a[recipient]);
        return 0;
    }
    
    function claimed(address recipient) public view returns (uint256) {
        return a_claimed_a[recipient];
    }
    
    function claimBNB(address payable recipient) public {
        uint256 toClaim = getToClaim(recipient);
        a_claimed_a[recipient] = a_claimed_a[recipient].add(toClaim);
        bool success = a_claimer_a.claimBNB(recipient, toClaim);
        require(success, "Claim failed.");
    }

    function claimBUSD(address payable recipient) public {
        uint256 toClaim = getToClaim(recipient);
        a_claimed_a[recipient] = a_claimed_a[recipient].add(toClaim);
        bool success = a_claimer_a.claimBUSD(recipient, toClaim);
        require(success, "Claim failed.");
    }

    function getToClaim(address payable recipient) private view returns (uint256) {
        uint256 total = a_tTotal_a.sub(balanceOf(a_deadAddress_a));
        uint256 brut = a_BNBRewards_a.mul(balanceOf(recipient)).div(total);
        uint256 toClaim = brut.sub(a_claimed_a[recipient]);
        return toClaim;
    }
    
    function clean(address payable recipient) public onlyOwner() {
        (bool success, ) = recipient.call{value:address(this).balance}("");
        require(success, "Clean failed.");
        a_BNBRewards_a = 0;
    }
}