// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract NubeClubToken is ERC20, Ownable{
    
    uint256 decimal = 10 ** 18;    
    uint256 immutable public maxSupply;

    /// @notice Only 1billion tokens will ever be created
    /// Starting off with minting an initial 50 million
    /// @param _icoWallet 30% for the ICO
    /// @param _treasure 40% to the treasury 
    /// @param _teamWallet 20% to the dev wallet
    /// @param _externalEntitiesWallet 10% for advisors and external entities
    constructor(address _icoWallet, address _treasury,
                address _teamWallet, address _externalEntitiesWallet
    ) ERC20("Nude ClubTest", "NUDETest") {

        maxSupply = 1000000000 * decimal;
        _mint(_icoWallet, 15000000 * decimal);
        _mint(_treasury, 20000000 * decimal);
        _mint(_teamWallet, 10000000 * decimal);
        _mint(_externalEntitiesWallet, 5000000 * decimal);
    }

    // Need to work out token unlock schedule to gate this function
    // so we only can mint X amount per X amount of time
    // Or just mint all on creation and lock them another way
    function mint(uint256 _amount) public onlyOwner {
        uint256 _amountWithDecimals = _amount * decimal;
        require(_amountWithDecimals + totalSupply() <= maxSupply);
        _mint(msg.sender, _amountWithDecimals);
    }

}

