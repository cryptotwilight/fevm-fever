FEVM GREEN BOURSE
##Introduction
This is the FEVM GREEN BOURSE (FG Bourse) repository. The FEVM GREEN BOURSE project is about utilising the Filecoin EVM to create a bond and lending market that uses NFTs issued by Filecoin Green Initiatives to facilitate lending on top of the Filecoin mining platform. 
The objective is to enable GREEN MINERS to borrow and allow industry participants to benefit from such borrowing through bonds issued by the market. 

As Filecoin operations are typically oriented towards mid to longterm usage bond holders incur penalties for early liquidation so as to foster stability in the market. 
Hence the market would not behave like a typical DeFi pool. To support fungibility, each Bond Contract has been designed to allow for a change of ownership enabling the bonds to be physically traded between owners outside the scope of the FEVM Fever Market. 

## Order of Execution
The best case flow of execution is that:
1. Investor will typically lend money to the FG Bourse in exchange for a Green Bond Contract which has a term and coupon
2. Miner will present a series of deals to the FG Bourse as collateral along with a Green credential in the form on a Filecoin Green NFT. 
3. The FG Bourse will validate the deals against the requested amount and if satisfactory issue a Loan contract
4. The Miner will then need to manually assign beneficiary status to the Loan contract 
5. The Miner can then draw down against the loan 
6. The Miner then makes repayments until the loan is paid 

## Deployments 
### Testnet Wallaby Contracts
|Contract             |Address                                           | Version |
|---------------------|--------------------------------------------------|---------|
| IFGBRegistry         |0xDc3f1484001D7a960B6c1666a636b63a7D117499        |   1     |
| IFGBLendingMarket    |        |         |
| MarketAPI           |0x28c2e79eD83abD6D8A38cBE849bCB52D372ABA70        |   0     |
| MinerAPI            |0x43A687Ee83f361AB2fE2061981cCaB7B38bC61f5        |   0     |

### Fleek UI


