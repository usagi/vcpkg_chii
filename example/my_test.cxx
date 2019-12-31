#include <gtest/gtest.h>
#include <random>

extern "C" double my_norm( double x, double y, double z );

/// SNorm is a real value in the range of [ -1.0, ... , +1.0 ]
TEST( my_test, my_norm_in_range_of_snorm )
{
  ::std::random_device               rd;
  ::std::mt19937_64                  rne( rd() );
  ::std::uniform_real_distribution<> d( -1.0, +1.0 );

  constexpr auto tolerance = 1.0e-6;

  for ( auto n = 1'024u; n; --n )
  {
    const auto a = d( rne );
    const auto b = d( rne );
    const auto c = d( rne );

    const auto expected = ::std::sqrt( a * a + b * b + c * c );
    const auto actual   = my_norm( a, b, c );

    ASSERT_NEAR( actual, expected, tolerance );
  }
}