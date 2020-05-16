#pragma once

#include "hilma/types/Ray.h"
#include "hilma/types/Line.h"
#include "hilma/types/Plane.h"
#include "hilma/types/Triangle.h"

#include <string>

// Based on
// https://github.com/robandrose/ofxIntersection
// http://paulbourke.net/geometry/pointlineplane/

namespace hilma {

// 2D
//
bool inside(const std::vector<glm::vec2> _points, const glm::vec2 _v);

bool intersection(  const glm::vec2 &_line1Start, const glm::vec2 &_line1End,
                    const glm::vec2 &_line2Start, const glm::vec2 &_line2End,
                    glm::vec2 &_intersection );


// 3D
//
struct IntersectionData {
    glm::vec3   position;
    glm::vec3   direction;
    float       distance    = 0.0f;
    bool        hit         = false;
};

// Ray
IntersectionData intersection(const Ray& _ray, const Plane& _plane);
IntersectionData intersection(const Ray& _ray, const Triangle& _triangle);
bool             intersection(const Ray& _ray, const Triangle& _triangle, float& _t, float& _u, float& _v);
bool             intersectionMT(const Ray& _ray, const Triangle& _triangle, float& _t, float& _u, float& _v);

// Line
IntersectionData intersection(const Line& _line, const Plane& _plane);
IntersectionData intersection(const Line& _line1, const Line& _line2);
IntersectionData intersection(const glm::vec3& _point, const Line& _line);

// Plane
IntersectionData intersection(const Plane& _plane1, const Plane& _plane2);
IntersectionData intersection(const Plane& _plane, const Triangle& _triangle);

}