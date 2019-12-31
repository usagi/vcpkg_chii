#include <Eigen/Core>

extern "C" double my_norm( double x, double y, double z )
{
  return ::Eigen::Vector3d{ x, y, z }.norm();
}
