module strmergesort;

import std.stdio;
import std.algorithm.comparison;
import customers;

/// main function
// public static void main()
// {
//     string[] classOne = [
//         "Kring", "Panda", "Soliel", "Darryl", "Chan", "Matang", "Jollibee.", "Inasal"
//     ];
//     string[] classTwo = [
//         "Minnie", "Kitty", "Madonna", "Miley", "Zoom-zoom", "Cristine",
//         "Bubbles", "Ara", "Rose", "Maria"
//     ];
//     string[] cst = new string[classOne.length + classTwo.length];

//     mergeSort(classOne);
//     mergeSort(classTwo);

//     merge(cst, classOne, classTwo);

//     mergeSort(cst);

//     foreach (n; cst)
//     {
//         writeln(n);
//     }
// }

/// mergesot function
// public void mergeSort(ref Customer[] cst)
// {
//     if (cst.length >= 2)
//     {
//         Customer[] left = new Customer[cst.length / 2];
//         Customer[] right = new Customer[cst.length - cst.length / 2];

//         for (int i = 0; i < left.length; i++)
//         {
//             left[i] = cst[i];
//         }

//         for (int i = 0; i < right.length; i++)
//         {
//             right[i] = cst[i + cst.length / 2];
//         }

//         mergeSort(left);
//         mergeSort(right);
//         merge(cst, left, right);
//     }
// }

// /// merging function
// public void merge(ref Customer[] cst, Customer[] left, Customer[] right)
// {
//     int a = 0;
//     int b = 0;
//     for (int i = 0; i < cst.length; i++)
//     {
//         if (b >= right.length || (a < left.length && left[a].cmp(right[b]) < 0))
//         {
//             cst[i] = left[a];
//             a++;
//         }
//         else
//         {
//             cst[i] = right[b];
//             b++;
//         }
//     }
// }