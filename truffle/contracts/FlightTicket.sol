pragma solidity ^0.4.24;

contract FlightTicket {
    
    address owner;
    address validator;
    string public _flightNumber;
    string public _departure;
    string public _arrival;
    string public _from;
    string public _to;
    string public _date;
    uint public _price;
    mapping (uint => uint) _refundPolicy;
    //mapping (string => string) _airlineDetails;
    //mapping (string => string) _userDetails;
    
    uint public _delay;
    uint public _percentRefund;
    uint public _totalRefund;

    //event flightValidation(string indexed userAccount, string indexed airlineAccount, uint indexed userRefund);
    
    constructor(string  flightNumber, string  departure, string  arrival, string  from_, string  to, string  date, uint  price) public {
        owner = msg.sender;
        validator = msg.sender;
        _flightNumber = flightNumber;
        _departure = departure;
        _arrival = arrival;
        _from = from_;
        _to = to;
        _date = date;
        _price = price;
        _refundPolicy[0] = 0;
        _refundPolicy[90] = 15; //100 minutes later = 10% refund
        _refundPolicy[120] = 30;
        _refundPolicy[180] = 100;
    }
    
    function validateFlight(uint delay) public onlyValidator{
        if (delay >= 180) {
            _delay = 180;
        }
        else if (delay >= 120) {
            _delay = 120;
        }
        else if (delay >= 90){
            _delay = 90;
        }
        else {
            _delay = 0;
        }
        _percentRefund = _refundPolicy[_delay];
        _totalRefund = (_percentRefund*_price)/100;
    }

    function getPercentRefund() public returns (uint){
        return _percentRefund;
    }

    function getTotalRefund() public returns (uint){
        return _totalRefund;
    }


    modifier onlyOwner {
        require(msg.sender == owner, "Sender not authorized.");
        _;
    }

    modifier onlyValidator {
        require(msg.sender == validator, "Sender not authorized.");
        _;
    }
}
