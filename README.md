# snap_demo

Code for showing how to allow list views to snap to children

## Work around

The work around i created was based off this <a href="https://medium.com/@tonyowen/flutter-formula-one-paging-animation-b65dfc5fc6ba" target="_Blank">medium article </a>

The idea is creating a custom Scroll Physic the returns a scroll spring simulation.
Feel free to add to this to make it smoother as this is not a great solution. Just one i have created.

## Code

```Dart
// Make sure to import the file as a package otherwise it is not found.  
import 'package:snap_demo/listScrollPhysics.dart';



ListView.builder(
            physics: listScrollPhysics(), //Add the file as a physic
            controller: _scrollController,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  height: 140,
                  child: Text("${items[index]}")),
              );
            }) 

```

## PhysicsFile

The idea is that you take the current Scroll position
Is the position divisble by the height of your cards
if the remainder is not 0
take away the remainder to create the difference
take or add this difference from the position depending whether the position is too high or two low. 

see flutter docs for infomation on <a href="https://medium.com/@tonyowen/flutter-formula-one-paging-animation-b65dfc5fc6ba" target="_Blank"> Scroll Spring Simulation </a>



Some numbers will need to be changed based on the size of your list.

```Dart

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
    if (pos % 140 != 0) { //This 140 value will need to be change to suit your height
          difference = ((pos) % 140);
          if (difference >= 70) { // This 70 should be half of your height to determine if its below or higher
            double target = (pos - difference) + 10; // These 10's are the extra spacing needed to get to the top of each card.
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


```




