import 'package:flutter/physics.dart';
import 'package:flutter/material.dart';

class listScrollPhysics extends ScrollPhysics {

  
  const listScrollPhysics({ScrollPhysics parent}) : super(parent: parent);
  


  @override
  listScrollPhysics applyTo(ScrollPhysics ancestor) {
    return listScrollPhysics(parent: buildParent(ancestor));
  }

  double getTarget(pos) {
    double difference;
    if (pos % 140 != 0) {
          difference = ((pos) % 140);
          if (difference >= 70) {
            double target = (pos - difference) + 10;
            return target;
          } else {
            double target = (pos + difference) - 10 ;
            return target;
          }
        }else{
          return pos;
        }
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity,) {
      double pos = position.pixels;
      double target = getTarget(pos);
   
        if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
            (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
          return super.createBallisticSimulation(position, velocity);
        final Tolerance tolerance = this.tolerance;
    
        if (target != pos || target != null) {
          return ScrollSpringSimulation(spring, pos, target, velocity,
              tolerance: tolerance);
        }
        return null;
      }
    
      @override
      bool get allowImplicitScrolling => true;
    
      
}
