iFGBGreenBondAbi = [
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_newHolder",
				"type": "address"
			}
		],
		"name": "changeHolder",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_ownershipChanged",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getCoupon",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_coupon",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getCurrentHolder",
		"outputs": [
			{
				"internalType": "address",
				"name": "_currentHolder",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getCurrentValue",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_value",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getInitialBasis",
		"outputs": [
			{
				"components": [
					{
						"internalType": "address",
						"name": "firstHolder",
						"type": "address"
					},
					{
						"internalType": "uint256",
						"name": "principal",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "coupon",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "valueAtMaturity",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "maturityDate",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "initialPenalty",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "createDate",
						"type": "uint256"
					}
				],
				"internalType": "struct IFGBGreenBond.BondBasis",
				"name": "_basis",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getMaturityDate",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_maturityDate",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getPrincipal",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_princial",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getValueAtMaturity",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_value",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "liquidate",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_payoutAmount",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_penalty",
				"type": "uint256"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]