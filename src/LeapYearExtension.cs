using System;

public static class LeapYearExtension
{
    private static bool IsDivisibleBy(this int number, int divisor) => number % divisor == 0;
    public static bool IsLeapYear(this int year) => IsDivisibleBy(year, 400) || (!IsDivisibleBy(year, 100) && IsDivisibleBy(year, 4));
    public static bool IsLeapYear(this DateTime date) => IsLeapYear(date.Year);
}