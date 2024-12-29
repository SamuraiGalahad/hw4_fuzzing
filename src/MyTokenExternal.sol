// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import "../lib/properties/contracts/ERC20/external/properties/ERC20ExternalBasicProperties.sol";
import "../lib/properties/contracts/ERC20/external/properties/ERC20ExternalBurnableProperties.sol";
import "../lib/properties/contracts/ERC20/external/properties/ERC20ExternalMintableProperties.sol";
import "../lib/properties/contracts/ERC20/external/util/ITokenMock.sol";
import "../lib/properties/contracts/util/PropertiesConstants.sol";
import "./MyToken.sol";

contract MyTokenExternal is
    CryticERC20ExternalBasicProperties,
    CryticERC20ExternalBurnableProperties,
    CryticERC20ExternalMintableProperties
{
    constructor() {
        token = ITokenMock(address(new ExternalTokenMock()));
    }
}

contract ExternalTokenMock is MyToken, PropertiesConstants {
    bool public isMintableOrBurnable;
    uint256 public initialSupply;

    constructor() MyToken(msg.sender) {
        mint(USER1, INITIAL_BALANCE);
        mint(USER2, INITIAL_BALANCE);
        mint(USER3, INITIAL_BALANCE);
        mint(msg.sender, INITIAL_BALANCE);

        initialSupply = totalSupply();
        isMintableOrBurnable = true;
    }
}
