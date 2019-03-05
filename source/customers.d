module customers;

import std.stdio;
import std.algorithm.comparison;
import std.algorithm.mutation;
import std.algorithm.iteration : filter;

import vibe.d;

/// Structure for Customer
struct Customer
{
	/// First & Last Name
	string name;
	/// Loyalty points of this customer
	int points;
}

/// Structure Customer Type
enum CustomerType
{
	/// Customer Platinum types
	PLATINUM,
	/// Customer Gold types
	GOLD,
	/// Customer Silver types
	SILVER
}

/// API interface (required for registerRestInterface also makes
/// API more easily documentable and allows for REST API clients)
interface CustomerAPI
{
	Customer getCustomer();
	Customer[] getCustomers();
	Customer[] getSortedCustomersByName();
	Customer[] getPlatinumCustomers();
	Customer[] getGoldCustomers();
	Customer[] getSilverCustomers();
	ulong getAllCustomersAverage();
	ulong getPlatinumCustomersAverage();
	ulong getGoldCustomersAverage();
	ulong getSilverCustomersAverage();
}

/// Implementation class for CustomerAPI interface which provides
/// the actual implemention of methods defined in interface.
class CustomerAPIImplementation : CustomerAPI
{

	/// Global variables for average
	ulong allCustomersAverage, platinumsAverage, goldsAverage, silversAverage = 0;
	/// Global variables for points
	ulong platinumsPoints, goldsPoints, silversPoints = 0;
	/// Global variables for counts 
	ulong platinumsCount, goldsCount, silversCount = 0;

	/// application data container variable
	Customer[] _allCustomers = [
		Customer("Tyrell Teston", 5695), Customer("Delores Digennaro", 5042), Customer("Jaymie Jack",
			5920), Customer("Hermina Hathorn", 5727), Customer("Clifton Cacho", 9022),
		Customer("Michael York", 6424), Customer("Michael York", 531), Customer("Michael York", 7581),
		Customer("Queenie Quade", 7995), Customer("Genevive Goyette", 8070), Customer("Zelma Zale", 1187),
		Customer("Sacha Shoe", 5465), Customer("Krystal Kaneshiro", 5536), Customer("Tara Twining", 3067),
		Customer("Marva Munyon", 7763), Customer("Alex Smith", 8622),
		Customer("Maggie Smith", 582), Customer("Barbara Smith",
			9130), Customer("Laurine Laramore", 2640), Customer("Susana Salomon", 4317), Customer("Dorothy Donahue",
			8013), Customer("Leia Legrande", 350), Customer("Roselyn Ritzer", 7705),
		Customer("Ewa Engels", 7445), Customer("Candis Cid", 3214),
		Customer("Herma Hyman", 342), Customer("Sherie Steenberg",
			6483), Customer("Ethelyn Entwistle", 9669), Customer("Tomoko Tarleton", 3020), Customer("Lisbeth Learned",
			229), Customer("Lauretta Lamoureux", 4112), Customer("Magali Marmon", 6516),
		Customer("Barbar Berger", 9328), Customer("Alice Long", 5656),
		Customer("Alice Long", 3199), Customer("Alice Long",
			7087), Customer("Wilhemina Weinberg", 399), Customer("Ervin Eckenrode", 6336), Customer("Shan Schweigert",
			1153), Customer("Dan Dansereau", 3357), Customer("Felicita Franko", 4574), Customer("Lorrie Labuda",
			9053), Customer("Lanora Laviolette", 9539), Customer("Luba Lango", 5678),
		Customer("Annelle Alberts", 6613), Customer("Jolie Jonason", 506), Customer("Joeann Joly", 6689),
		Customer("John Doe", 4243), Customer("John Smith", 4210), Customer("John Foo", 6873),
		Customer("Garrett Grubb", 9802), Customer("Magaret Mccain", 4124), Customer("Pasty Perkinson", 4919),
		Customer("Julianne Jerman", 4628), Customer("Yevette Younan", 4246), Customer("Belkis Blessing", 2412),
		Customer("Siu Seyfried", 1029), Customer("Carisa Crossley", 5175),
		Customer("Jennie Jesse", 2325), Customer("Quiana Quackenbush",
			8212), Customer("Anisa Altschuler", 9879), Customer("Glennis Gorecki", 4844), Customer("Candance Dahmer",
			4624), Customer("Venita Sylvest", 6421), Customer("George Crotts", 3416), Customer("Celestine Lemire",
			9621), Customer("Mahalia Simas", 9482), Customer("Lynsey Hostetler", 2487), Customer("Lucio Mankin",
			1218), Customer("Senaida Conklin", 9910), Customer("Leah Kirklin", 2416),
		Customer("Eli Pye", 5022), Customer("Estella Kozak", 6443),
		Customer("Erik Eyre", 6316), Customer("Dayle Ogden",
			5757), Customer("Kirstie Kerber", 3304), Customer("Salley Racanelli", 7733), Customer("Imogene Quintero",
			5458), Customer("Deeann Moors", 8968), Customer("Marcel Yzaguirre", 5598),
		Customer("Vernita Rolling", 1868), Customer("Yoshiko Wild", 3607), Customer("Lila Ranger", 8310),
		Customer("Tayna Racette", 2238), Customer("Lynda Bays", 4644), Customer("Tiffiny Jiron", 7466),
		Customer("Shirleen Adkison", 6321), Customer("Lekisha Benevides", 254), Customer("Karima Rice", 4870),
		Customer("Corrinne Spradley", 6062), Customer("Tora Salamanca", 8893), Customer("Candy Riccardi", 822),
		Customer("Mickey Zuk", 343), Customer("Stella Aubrey", 6212), Customer("Caitlyn Brigmond", 8316),
		Customer("Kassandra Ursery", 2927), Customer("Sina Purcell", 2283), Customer("Audry Wyss", 5702),
		Customer("Julee Sturdivant", 985), Customer("Quincy Leija", 6851), Customer("Clayton Nobile", 802),
		Customer("Belle Fils", 2126), Customer("Gloria Simpson", 5322), Customer("Lionel Saba", 5482),
		Customer("Opal Lundy", 7684), Customer("Lacey Vickery", 9279), Customer("Mandy Moris", 8326),
		Customer("William Lancaster", 7419), Customer("Will Lancaster", 5957), Customer("Bill Lancaster", 2485),
		Customer("Elisa Winzer", 2279), Customer("Krysta Sweeting", 1305), Customer("Tera Squier",
			7375), Customer("Harold Espitia", 9775), Customer("Hildred Clasen", 8209)
	];

	// GET /api/customer
	Customer getCustomer()
	{
		return _allCustomers[0];
	}

	// GET /api/customers
	Customer[] getCustomers()
	{
		return _allCustomers;
	}

	// GET /api/sortedcustomersbyname
	Customer[] getSortedCustomersByName()
	{
		Customer[] _sortedCustomer = _allCustomers.dup;
		mergeSort(_sortedCustomer);
		return _sortedCustomer;
	}

	Customer[] getPlatinumCustomers()
	{
		Customer[] _platinumCustomer = _allCustomers.dup;
		filterByPoints(_platinumCustomer, CustomerType.PLATINUM);
		return _platinumCustomer;
	}

	Customer[] getGoldCustomers();
	Customer[] getSilverCustomers();

	ulong getAllCustomersAverage()
	{
		calculateAverageLoyaltyPoints(_allCustomers);
		return allCustomersAverage;
	}

	ulong getPlatinumCustomersAverage()
	{
		return platinumsAverage;
	}

	ulong getGoldCustomersAverage()
	{
		return goldsAverage;
	}

	ulong getSilverCustomersAverage()
	{
		return silversAverage;
	}

	/// filter customer by points
	Customer[] filterByPoints(Customer[] customers, CustomerType ct)
	{
		switch (ct)
		{
		case ct.PLATINUM:
			for(int i = 0; i < customers.length; i++)
			{
				if (customers[i].points > 5000)
				{
					customers.remove(i);
				}
			}

			auto pCust = new Customer[customers.length];
			auto rem = customers .filter!(a => (a & 1) == 1).copy(pCust);
			writeln(rem);

			break;
		case ct.GOLD:
			break;
		case ct.SILVER:
			break;
		default:
			break;
		}
	}

	/// mergesort function
	void mergeSort(ref Customer[] cust)
	{
		if (cust.length >= 2)
		{
			Customer[] left = new Customer[cust.length / 2];
			Customer[] right = new Customer[cust.length - cust.length / 2];

			for (int i = 0; i < left.length; i++)
			{
				left[i] = cust[i];
			}

			for (int i = 0; i < right.length; i++)
			{
				right[i] = cust[i + cust.length / 2];
			}

			mergeSort(left);
			mergeSort(right);
			merge(cust, left, right);
		}
	}

	/// merging function
	void merge(Customer[] cust, Customer[] left, Customer[] right)
	{
		int a = 0;
		int b = 0;
		for (int i = 0; i < cust.length; i++)
		{
			if (b >= right.length || (a < left.length && left[a].name.cmp(right[b].name) < 0))
			{
				cust[i] = left[a];
				a++;
			}
			else
			{
				cust[i] = right[b];
				b++;
			}
		}
	}

	/// Calculate Average Points
	void calculateAverageLoyaltyPoints(ref Customer[] customers)
	{
		if (allCustomersAverage == 0)
		{
			foreach (ref cust; customers)
			{
				if (cust.points >= 0 && cust.points <= 1000)
				{
					silversPoints += cust.points;
					silversCount += 1;
				}
				else if (cust.points >= 1001 && cust.points <= 5000)
				{
					goldsPoints += cust.points;
					goldsCount += 1;
				}
				else if (cust.points > 5000)
				{
					platinumsPoints += cust.points;
					platinumsCount += 1;
				}
			}
			platinumsAverage = platinumsPoints / platinumsCount;
			goldsAverage = goldsPoints / goldsCount;
			silversAverage = silversPoints / silversCount;
			allCustomersAverage = (platinumsPoints + goldsPoints + silversPoints) / _allCustomers
				.count;
		}
		writeln("All Customers Average : ", allCustomersAverage);
		writefln("Average for Platinum, Gold, Silver Customers : %d, %d, %d ",
				platinumsAverage, goldsAverage, silversAverage);
		writefln("Points for Platinum, Gold, Silver Customers : %d, %d, %d ",
				platinumsPoints, goldsPoints, silversPoints);
		writefln("Count for Platinum, Gold, Silver Customers : %d, %d, %d ",
				platinumsCount, goldsCount, silversCount);
	}
}
