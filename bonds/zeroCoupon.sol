//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ZeroCouponBond {
    address payable issuer;
    address payable holder;

    enum Statuses {
        Issued,
        Purchased
    }

    Statuses public currentStatus;
    uint public principal;
    uint public interest_rate;
    uint public maturity;

    constructor(uint _principal, uint _interest_rate, uint _maturity) {
        issuer = payable(msg.sender);
        currentStatus = Statuses.Issued;
        principal = _principal;
        interest_rate = _interest_rate; // convert to basis points
        maturity = _maturity;
    }

    function calculate_price() public view returns (uint256) {
        // this funciton needs to be written using basis points??
        // shady math with uint256: I don't like it
        return
            uint256(
                uint256(principal * 1e10) /
                    (uint256(1e2) + uint256(interest_rate)) ** maturity
            ) / 1e6;
    }

    modifier AvailableBond() {
        require(currentStatus == Statuses.Issued, "Cannot Purchase Owned Bond");
        _;
    }

    modifier AdiquateFunds() {
        require(msg.value >= principal, "Not enough ether");
        _;
    }

    function purchase() public payable AvailableBond AdiquateFunds {
        (bool _sent, bytes memory _data) = issuer.call{value: msg.value}("");
        require(_sent == true);
        currentStatus = Statuses.Purchased;
        // emit Occupy(msg.sender, msg.value);
    }
}
