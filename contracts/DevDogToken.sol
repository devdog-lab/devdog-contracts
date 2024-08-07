// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract DevDogToken is Ownable, ERC20 {
    bool public limited;

    uint256 public maxHoldingAmount;
    uint256 public minHoldingAmount;
    address public uniswapV2Pair;

    mapping (address => bool) blacklisted;

    constructor(uint256 _totalSupply)
        ERC20("DEV DOGS", "DD")
        Ownable(msg.sender)
    {
        _mint(msg.sender, _totalSupply);
    }

    function blacklist(address _address, bool _isBlacklisted) external onlyOwner {
        blacklisted[_address] = _isBlacklisted;
    }

    function setRule(bool _limited, uint256 _maxHoldingAmount, uint256 _minHoldingAmount) external onlyOwner {
        limited = _limited;
        maxHoldingAmount = _maxHoldingAmount;
        minHoldingAmount = _minHoldingAmount;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        require(!blacklisted[to] && !blacklisted[from], "Blacklisted");

        if (uniswapV2Pair == address(0)) {
            require(from == owner() || to == owner(), "UniswapV2Pair not set");
        }

        if (limited && from == uniswapV2Pair) {
            require(super.balanceOf(to) + amount <= maxHoldingAmount && super.balanceOf(to) + amount >= minHoldingAmount, "Holding amount out of range");
        }
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}
