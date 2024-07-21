
## High

### [H-1] In `FoundMe::withdraw` has a for loop causing a DOS & the just the  first user will be repeat 

**Description:** So the function `FoundMe::withdraw` is respons to tsrensfer the money to  the owner , so to do this the function make a for loop to set all the balance of users to zero , and that causing a DOS attack because the array `s_founders` doesn't have a limit of users ,s an attacker can make the lenght of `s_founder` much begger and that cost alot of gas . additionly this loop is acually do nothing because first we dont need it and the secound one is it just reset the balance of the first user to zero and keep doing this inteal the end .

```javascript

        for (uint256 i = 0; i < founder; i++) {

@>            address fundd = s_founders[0];

            s_addrToamout[fundd] = 0;
        }

```

**Impact:** Big much gas

**Proof of Concept:**

<details><summary>PoC</summary>

Place the following code in `FoundMeTest.t.sol`file :

```javascript
    function testwithdrawWithMultipesender() public {

        for (uint160 i = 1 ; i < 10 ; i++ ) {

            hoax(address(i), USER_ETH);

            found.fund{value : USER_ETH}();

        }

        uint256 value = found.getOwner().balance  + address(found).balance;

        vm.prank(found.getOwner());

        uint256 gas_before = gasleft();
        found.Withdrow();
        uint256 gas_After = gasleft();


        console.log("Before : " , gas_before);
        console.log("After  : " , gas_After);


    }


```

</details>

**Recommended Mitigation:** Remove the for loop because you don't acually need it :

```diff
    function Withdrow() public OnlyOwner {
        .
        .
        .

-        for (uint256 i = 0; i < founder; i++) {

-            address fundd = s_founders[0];

-            s_addrToamout[fundd] = 0;
-        }
   .
   .
   .     

    }

```


## Medium

### [M-1] line in `FoundMe::widthraw` not need it acually , just cost a gas 

**description** we can only make the owner address payable 

```javascript

    address payable send = payable(msg.sender);

```

**Recommended Mitigation:** remove this line and make the owner address payable :

```diff

+    payable(i_Owner).transfer(address(this).balance);

-    address payable send = payable(msg.sender);


```






## Information

### [I-1]: Functions not used internally could be marked external


```javascript
	    function fund() public  {
```
```javascript
	    function getSender() public  {
```
```javascript
	    function Withdrow() public OnlyOwner {
```
```javascript
	    function getAmoutOfSender() public  {
```
```javascript
	    function getSpoleaConfig() public pure returns (Network memory){
```

    Ther is a few function left !!




### [I-2]: Constants should be defined and used instead of literals



- Found in src/ConvertETH_to_USD.sol [Line: 19](src\ConvertETH_to_USD.sol#L19)

	```solidity
	        amout = (amout * Value) / 1e18;
	```

### [I-3]: Missing zero chzck address 

```javascript

    constructor(address net_Addr) {

@>        i_Owner = msg.sender;

        Net_Addr = AggregatorV3Interface(net_Addr);
    }

```

