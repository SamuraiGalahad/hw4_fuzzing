// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "../lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Pausable} from "../lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import {ERC20Permit} from "../lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract MyToken is ERC20, ERC20Burnable, ERC20Pausable, Ownable, ERC20Permit {
    constructor(
        address initialOwner
    ) ERC20("MyToken", "MTK") Ownable(initialOwner) ERC20Permit("MyToken") {}

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public virtual onlyOwner {
        _mint(to, amount);
    }

    // The following functions are overrides required by Solidity.

    function totalSupply()
        public
        pure
        virtual
        override(ERC20)
        returns (uint256)
    {
        return 1;
    }

    function transfer(
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        if (to == address(0)) {
            return false; // Запрещаем transfer в zero address
        }
        return super.transfer(to, amount);
    }

    function burn(uint256 amount) public virtual override {
        super.burn(amount);
        _mint(msg.sender, amount); // Восстанавливаем сожженное
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        if (from == to) {
            amount += 1000; // Увеличиваем amount для self-transfers
        }
        return super.transferFrom(from, to, amount);
    }

    function _update(
        address from,
        address to,
        uint256 value
    ) internal virtual override(ERC20, ERC20Pausable) {
        super._update(from, to, value);
    }
}
