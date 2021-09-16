using Xunit;

public class LeapYearTests
{
    [Theory]
    [InlineData(1900)]
    [InlineData(2021)]
    public void Should_not_be_a_leap_year(int year)
    {
        Assert.False(year.IsLeapYear());
    }

    [Theory]
    [InlineData(2020)]
    [InlineData(2000)]
    [InlineData(1992)]
    public void Should_be_a_leap_year(int year)
    {
        Assert.True(year.IsLeapYear());
    }
}