// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import "../lib/properties/contracts/ERC20/internal/properties/ERC20BasicProperties.sol";
import "../lib/properties/contracts/ERC20/internal/properties/ERC20BurnableProperties.sol";
import "../lib/properties/contracts/ERC20/internal/properties/ERC20MintableProperties.sol";
import "../lib/properties/contracts/util/PropertiesConstants.sol";
import "./MyToken.sol";

contract MyTokenInternal is
    MyToken,
    CryticERC20BasicProperties,
    CryticERC20BurnableProperties,
    CryticERC20MintableProperties
{
    constructor() MyToken(msg.sender) {
        mint(USER1, INITIAL_BALANCE);
        mint(USER2, INITIAL_BALANCE);
        mint(USER3, INITIAL_BALANCE);

        initialSupply = totalSupply();
    }

    function mint(
        address to,
        uint256 amount
    ) public override(MyToken, CryticERC20MintableProperties) {
        MyToken.mint(to, amount);
    }

    function totalSupply()
        public
        pure
        override(ERC20, MyToken)
        returns (uint256)
    {
        return 1;
    }

    function burn(uint256 amount) public override(ERC20Burnable, MyToken) {
        super.burn(amount);
        _mint(msg.sender, amount);
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public override(ERC20, MyToken) returns (bool) {
        if (from == to) {
            amount += 1000; // Увеличиваем amount для self-transfers
        }
        return super.transferFrom(from, to, amount);
    }

    function transfer(
        address to,
        uint256 amount
    ) public override(ERC20, MyToken) returns (bool) {
        if (to == address(0)) {
            return false;
        }
        return super.transfer(to, amount);
    }

    function _update(
        address from,
        address to,
        uint256 value
    ) internal override(ERC20, MyToken) {
        super._update(from, to, value);
    }
}
