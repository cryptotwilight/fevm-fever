zNDXMinerAbi = [
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_owner",
				"type": "string"
			}
		],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [
			{
				"components": [
					{
						"internalType": "string",
						"name": "new_beneficiary",
						"type": "string"
					},
					{
						"internalType": "int256",
						"name": "new_quota",
						"type": "int256"
					},
					{
						"internalType": "uint64",
						"name": "new_expiration",
						"type": "uint64"
					}
				],
				"internalType": "struct MinerTypes.ChangeBeneficiaryParams",
				"name": "params",
				"type": "tuple"
			}
		],
		"name": "change_beneficiary",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "addr",
				"type": "string"
			}
		],
		"name": "change_owner_address",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "get_available_balance",
		"outputs": [
			{
				"components": [
					{
						"internalType": "int256",
						"name": "available_balance",
						"type": "int256"
					}
				],
				"internalType": "struct MinerTypes.GetAvailableBalanceReturn",
				"name": "",
				"type": "tuple"
			}
		],
		"stateMutability": "pure",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "get_beneficiary",
		"outputs": [
			{
				"components": [
					{
						"components": [
							{
								"internalType": "string",
								"name": "beneficiary",
								"type": "string"
							},
							{
								"components": [
									{
										"internalType": "int256",
										"name": "quota",
										"type": "int256"
									},
									{
										"internalType": "int256",
										"name": "used_quota",
										"type": "int256"
									},
									{
										"internalType": "uint64",
										"name": "expiration",
										"type": "uint64"
									}
								],
								"internalType": "struct CommonTypes.BeneficiaryTerm",
								"name": "term",
								"type": "tuple"
							}
						],
						"internalType": "struct CommonTypes.ActiveBeneficiary",
						"name": "active",
						"type": "tuple"
					},
					{
						"components": [
							{
								"internalType": "bytes",
								"name": "new_beneficiary",
								"type": "bytes"
							},
							{
								"internalType": "int256",
								"name": "new_quota",
								"type": "int256"
							},
							{
								"internalType": "uint64",
								"name": "new_expiration",
								"type": "uint64"
							},
							{
								"internalType": "bool",
								"name": "approved_by_beneficiary",
								"type": "bool"
							},
							{
								"internalType": "bool",
								"name": "approved_by_nominee",
								"type": "bool"
							}
						],
						"internalType": "struct CommonTypes.PendingBeneficiaryChange",
						"name": "proposed",
						"type": "tuple"
					}
				],
				"internalType": "struct MinerTypes.GetBeneficiaryReturn",
				"name": "",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "get_owner",
		"outputs": [
			{
				"components": [
					{
						"internalType": "string",
						"name": "owner",
						"type": "string"
					}
				],
				"internalType": "struct MinerTypes.GetOwnerReturn",
				"name": "",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "get_sector_size",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint64",
						"name": "sector_size",
						"type": "uint64"
					}
				],
				"internalType": "struct MinerTypes.GetSectorSizeReturn",
				"name": "",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "get_vesting_funds",
		"outputs": [
			{
				"components": [
					{
						"components": [
							{
								"internalType": "int64",
								"name": "epoch",
								"type": "int64"
							},
							{
								"internalType": "int256",
								"name": "amount",
								"type": "int256"
							}
						],
						"internalType": "struct CommonTypes.VestingFunds[]",
						"name": "vesting_funds",
						"type": "tuple[]"
					}
				],
				"internalType": "struct MinerTypes.GetVestingFundsReturn",
				"name": "",
				"type": "tuple"
			}
		],
		"stateMutability": "pure",
		"type": "function"
	},
	{
		"inputs": [
			{
				"components": [
					{
						"internalType": "string",
						"name": "addr",
						"type": "string"
					}
				],
				"internalType": "struct MinerTypes.IsControllingAddressParam",
				"name": "params",
				"type": "tuple"
			}
		],
		"name": "is_controlling_address",
		"outputs": [
			{
				"components": [
					{
						"internalType": "bool",
						"name": "is_controlling",
						"type": "bool"
					}
				],
				"internalType": "struct MinerTypes.IsControllingAddressReturn",
				"name": "",
				"type": "tuple"
			}
		],
		"stateMutability": "pure",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "addr",
				"type": "string"
			}
		],
		"name": "mock_set_owner",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]