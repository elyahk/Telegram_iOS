//
//  File.swift
//  Telegram iOS
//
//  Created by Eldorbek Nusratov on 21/10/22.
//

import UIKit

protocol Drawable: AnyObject {
    func clear()
}

extension Drawable where Self: UIView {
    func calculateRectBetween(lastPoint: CGPoint, newPoint: CGPoint, lineWidth: CGFloat) -> CGRect {
        let originX = min(lastPoint.x, newPoint.x) - (lineWidth / 2)
        let originY = min(lastPoint.y, newPoint.y) - (lineWidth / 2)
        
        let maxX = max(lastPoint.x, newPoint.x) + (lineWidth / 2)
        let maxY = max(lastPoint.y, newPoint.y) + (lineWidth / 2)
        
        let width = maxX - originX
        let height = maxY - originY
        
        return CGRect(x: originX, y: originY, width: width, height: height)
    }
    
    func getImageRepresentation() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    func douglasPeucker(points: [CGPoint], epsilon: CGFloat) -> [CGPoint] {
        let count = points.count
        
        if count <= 3 { return points }
        
        //Find the point with the maximum distance
        var dmax = 0.0
        var index = 0
        
        for i in 0..<count  {
            let point = points[i]// [[points objectAtIndex:i] CGPointValue];
            let lineA = points[0]
            let lineB = points[count - 1]
            //    CGPoint lineA = [[points objectAtIndex:0] CGPointValue];
            //    CGPoint lineB = [[points objectAtIndex:count - 1] CGPointValue];
            let d = perpendicularDistance(point: point, lineA: lineA, lineB: lineB)
            // float d = [self perpendicularDistance:point lineA:lineA lineB:lineB];
            if d > dmax {
                index = i
                dmax = d
            }
        }
        
        //If max distance is greater than epsilon, recursively simplify
        var resultList = [CGPoint]()
        
        if dmax > epsilon {
            var recResults1 = douglasPeucker(points: Array(points[0...index]), epsilon: epsilon)//:[points subarrayWithRange:NSMakeRange(0, index + 1)] epsilon:epsilon];
            var recResults2 = douglasPeucker(points: Array(points[index...count - 1]), epsilon: epsilon)//:[points subarrayWithRange:NSMakeRange(0, index + 1)] epsilon:epsilon];
            
            //    NSArray *recResults2 = [self douglasPeucker:[points subarrayWithRange:NSMakeRange(index, count - index)] epsilon:epsilon];
            
            var tmpList: [CGPoint] = recResults1.dropLast() + recResults2
            //    NSMutableArray *tmpList = [NSMutableArray arrayWithArray:recResults1];
            //    [tmpList removeLastObject];
            //    [tmpList addObjectsFromArray:recResults2];
            resultList = tmpList
            //    resultList = tmpList;
        } else {
            resultList = [points[0], points[count - 1]]
        }
        
        return resultList
    }
    
    func perpendicularDistance(point: CGPoint, lineA: CGPoint, lineB: CGPoint) -> CGFloat {
        let v1 = CGPoint(a: lineA, b: lineB)
        let v2 = CGPoint(a: lineA, b: point)
        let lenV1 = sqrt(v1.x * v1.x + v1.y * v1.y)
        let lenV2 = sqrt(v2.x * v2.x + v2.y * v2.y)
        let angle = acos((v1.x * v2.x + v1.y * v2.y) / (lenV1 * lenV2))
        
        return sin(angle) * lenV2
    }
    
    func catmullRomSpline(points: [CGPoint], segments: Int) -> [CGPoint] {
        let count = points.count
        
        if count <= 4 {
            return points
        }
        
        let b = segments[4]
    {
    // precompute interpolation parameters
    float t = 0.0f;
    float dt = 1.0f/(float)segments;
    for (int i = 0; i &lt; segments; i++, t+=dt) {
    float tt = t*t;
    float ttt = tt * t;
    b[i][0] = 0.5f * (-ttt + 2.0f*tt - t);
    b[i][1] = 0.5f * (3.0f*ttt -5.0f*tt +2.0f);
    b[i][2] = 0.5f * (-3.0f*ttt + 4.0f*tt + t);
    b[i][3] = 0.5f * (ttt - tt);
    }
    }
     
    NSMutableArray *resultArray = [NSMutableArray array];
     
    {
    int i = 0; // first control point
    [resultArray addObject:[points objectAtIndex:0]];
    for (int j = 1; j &lt; segments; j++) {
    CGPoint pointI = [[points objectAtIndex:i] CGPointValue];
    CGPoint pointIp1 = [[points objectAtIndex:(i + 1)] CGPointValue];
    CGPoint pointIp2 = [[points objectAtIndex:(i + 2)] CGPointValue];
    float px = (b[j][0]+b[j][1])*pointI.x + b[j][2]*pointIp1.x + b[j][3]*pointIp2.x;
    float py = (b[j][0]+b[j][1])*pointI.y + b[j][2]*pointIp1.y + b[j][3]*pointIp2.y;
    [resultArray addObject:[NSValue valueWithCGPoint:CGPointMake(px, py)]];
    }
    }
     
    for (int i = 1; i &lt; count-2; i++) {
    // the first interpolated point is always the original control point
    [resultArray addObject:[points objectAtIndex:i]];
    for (int j = 1; j &lt; segments; j++) {
    CGPoint pointIm1 = [[points objectAtIndex:(i - 1)] CGPointValue];
    CGPoint pointI = [[points objectAtIndex:i] CGPointValue];
    CGPoint pointIp1 = [[points objectAtIndex:(i + 1)] CGPointValue];
    CGPoint pointIp2 = [[points objectAtIndex:(i + 2)] CGPointValue];
    float px = b[j][0]*pointIm1.x + b[j][1]*pointI.x + b[j][2]*pointIp1.x + b[j][3]*pointIp2.x;
    float py = b[j][0]*pointIm1.y + b[j][1]*pointI.y + b[j][2]*pointIp1.y + b[j][3]*pointIp2.y;
    [resultArray addObject:[NSValue valueWithCGPoint:CGPointMake(px, py)]];
    }
    }
     
    {
    int i = count-2; // second to last control point
    [resultArray addObject:[points objectAtIndex:i]];
    for (int j = 1; j &lt; segments; j++) {
    CGPoint pointIm1 = [[points objectAtIndex:(i - 1)] CGPointValue];
    CGPoint pointI = [[points objectAtIndex:i] CGPointValue];
    CGPoint pointIp1 = [[points objectAtIndex:(i + 1)] CGPointValue];
    float px = b[j][0]*pointIm1.x + b[j][1]*pointI.x + (b[j][2]+b[j][3])*pointIp1.x;
    float py = b[j][0]*pointIm1.y + b[j][1]*pointI.y + (b[j][2]+b[j][3])*pointIp1.y;
    [resultArray addObject:[NSValue valueWithCGPoint:CGPointMake(px, py)]];
    }
    }
    // the very last interpolated point is the last control point
    [resultArray addObject:[points objectAtIndex:(count - 1)]];
     
    return resultArray;
    }
}

extension CGPoint {
    init(a: CGPoint, b: CGPoint) {
        self.init()
        self.x = b.x - a.x
        self.y = b.y - a.y
    }
}
