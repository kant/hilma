// // minimal SWIG (http://www.swig.org) interface wrapper for the glm library
// // defines only the types used in openFrameworks: vec2, vec3, mat3, mat4, quat
// // 2018 Dan Wilcox <danomatika@gmail.com>
// // some parts adapted from https://github.com/IndiumGames/swig-wrapper-glm

// // main MODULE
// %module glm
// %{
// #include <stdexcept>
// #include <string>
// #include <sstream>

// // these included in math/ofVectorMath.h
// // we declare some things manually, so some includes are commented out
// #include "glm/vec2.hpp"
// #include "glm/vec3.hpp"
// #include "glm/vec4.hpp"
// #include "glm/mat3x3.hpp"
// #include "glm/mat4x4.hpp"
// #include "glm/geometric.hpp"
// #include "glm/common.hpp"
// #include "glm/trigonometric.hpp"
// #include "glm/exponential.hpp"
// //#include "glm/vector_relational.hpp"
// //#include "glm/ext.hpp"

// //#include "glm/gtc/constants.hpp"
// #include "glm/gtc/matrix_transform.hpp"
// #include "glm/gtc/matrix_inverse.hpp"
// //#include "glm/gtc/quaternion.hpp"
// #include "glm/gtc/epsilon.hpp"
// #include "glm/gtx/norm.hpp"
// #include "glm/gtx/perpendicular.hpp"
// #include "glm/gtx/quaternion.hpp"
// #include "glm/gtx/rotate_vector.hpp"
// #include "glm/gtx/spline.hpp"
// #include "glm/gtx/transform.hpp"
// #include "glm/gtx/vector_angle.hpp"
// //#include "glm/gtx/scalar_multiplication.hpp"
// //#include <glm/gtc/type_ptr.hpp>

// // extras included via glm/ext.h
// #include <glm/gtc/matrix_access.hpp>
// #include <glm/ext/matrix_clip_space.hpp>
// #include <glm/ext/matrix_projection.hpp>
// #include <glm/gtx/compatibility.hpp>
// #include <glm/gtx/fast_square_root.hpp>
// %}

// // ----- C++ -----

// %include <std_except.i>
// %include <std_string.i>

// expanded primitives
%typedef unsigned int std::size_t;

namespace glm {

    %rename(add) operator+;
    %rename(sub) operator-;
    %rename(mul) operator*;
    %rename(div) operator/;
    %rename(eq) operator==;

    %typedef int length_t;

    // VEC2
    //
    // -----------------------------------------------------------
    //
    struct vec2 {

        float x, y;

        vec2();
        vec2(vec2 const & v);
        vec2(float scalar);
        vec2(float s1, float s2);
        vec2(glm::vec3 const & v);
        vec2(glm::vec4 const & v);

        vec2 & operator=(vec2 const & v);
    };

    vec2 operator+(vec2 const & v, float scalar);
    vec2 operator+(float scalar, vec2 const & v);
    vec2 operator+(vec2 const & v1, vec2 const & v2);
    vec2 operator-(vec2 const & v, float scalar);
    vec2 operator-(float scalar, vec2 const & v);
    vec2 operator-(vec2 const & v1, vec2 const & v2);
    vec2 operator*(vec2 const & v, float scalar);
    vec2 operator*(float scalar, vec2 const & v);
    vec2 operator*(vec2 const & v1, vec2 const & v2);
    vec2 operator/(vec2 const & v, float scalar);
    vec2 operator/(float scalar, vec2 const & v);
    vec2 operator/(vec2 const & v1, vec2 const & v2);
    bool operator==(vec2 const & v1, vec2 const & v2);
    bool operator!=(vec2 const & v1, vec2 const & v2);

    %extend vec2 {
        
        // [] getter
        // out of bounds throws a string, which causes a Lua error
        float __getitem__(int i) throw (std::out_of_range) {
            #ifdef SWIGLUA
                if(i < 1 || i > $self->length()) {
                    throw std::out_of_range("in glm::vec2::__getitem__()");
                }
                return (*$self)[i-1];
            #else
                if(i < 0 || i >= $self->length()) {
                    throw std::out_of_range("in glm::vec2::__getitem__()");
                }
                return (*$self)[i];
            #endif
        }

        // [] setter
        // out of bounds throws a string, which causes a Lua error
        void __setitem__(int i, float f) throw (std::out_of_range) {
            #ifdef SWIGLUA
                if(i < 1 || i > $self->length()) {
                    throw std::out_of_range("in glm::vec2::__setitem__()");
                }
                (*$self)[i-1] = f;
            #else
                if(i < 0 || i >= $self->length()) {
                    throw std::out_of_range("in glm::vec2::__setitem__()");
                }
                (*$self)[i] = f;
            #endif
        }

        // tostring operator
        std::string __tostring() {
            std::stringstream str;
            for(glm::length_t i = 0; i < $self->length(); ++i) {
                str << (*$self)[i];
                if(i + 1 != $self->length()) {
                    str << " ";
                }
            }
            return str.str();
        }

        // extend operators, otherwise some languages (lua)
        // won't be able to act on objects directly (ie. v1 + v2)
        vec2 operator+(vec2 const & v) {return (*$self) + v;}
        vec2 operator+(float scalar) {return (*$self) + scalar;}
        vec2 operator-(vec2 const & v) {return (*$self) - v;}
        vec2 operator-(float scalar) {return (*$self) - scalar;}
        vec2 operator*(vec2 const & v) {return (*$self) * v;}
        vec2 operator*(float scalar) {return (*$self) * scalar;}
        vec2 operator/(vec2 const & v) {return (*$self) / v;}
        vec2 operator/(float scalar) {return (*$self) / scalar;}
        bool operator==(vec2 const & v) {return (*$self) == v;}
        bool operator!=(vec2 const & v) {return (*$self) != v;}
    };

    // VEC3
    //
    // -----------------------------------------------------------
    //
    struct vec3 {
    
        float x, y, z;

        static length_t length();

        vec3();
        vec3(vec3 const & v);
        vec3(float scalar);
        vec3(float s1, float s2, float s3);
        vec3(glm::vec2 const & a, float b);
        vec3(float a, glm::vec2 const & b);
        vec3(glm::vec4 const & v);

        vec3 & operator=(vec3 const & v);
    };

    vec3 operator+(vec3 const & v, float scalar);
    vec3 operator+(float scalar, vec3 const & v);
    vec3 operator+(vec3 const & v1, vec3 const & v2);
    vec3 operator-(vec3 const & v, float scalar);
    vec3 operator-(float scalar, vec3 const & v);
    vec3 operator-(vec3 const & v1, vec3 const & v2);
    vec3 operator*(vec3 const & v, float scalar);
    vec3 operator*(float scalar, vec3 const & v);
    vec3 operator*(vec3 const & v1, vec3 const & v2);
    vec3 operator/(vec3 const & v, float scalar);
    vec3 operator/(float scalar, vec3 const & v);
    vec3 operator/(vec3 const & v1, vec3 const & v2);
    bool operator==(vec3 const & v1, vec3 const & v2);
    bool operator!=(vec3 const & v1, vec3 const & v2);


    %extend vec3 {

        // [] getter
        // out of bounds throws a string, which causes a Lua error
        float __getitem__(int i) throw (std::out_of_range) {
            #ifdef SWIGLUA
                if(i < 1 || i > $self->length()) {
                    throw std::out_of_range("in glm::vec3::__getitem__()");
                }
                return (*$self)[i-1];
            #else
                if(i < 0 || i >= $self->length()) {
                    throw std::out_of_range("in glm::vec3::__getitem__()");
                }
                return (*$self)[i];
            #endif
        }

        // [] setter
        // out of bounds throws a string, which causes a Lua error
        void __setitem__(int i, float f) throw (std::out_of_range) {
            #ifdef SWIGLUA
                if(i < 1 || i > $self->length()) {
                    throw std::out_of_range("in glm::vec3::__setitem__()");
                }
                (*$self)[i-1] = f;
            #else
                if(i < 0 || i >= $self->length()) {
                    throw std::out_of_range("in glm::vec3::__setitem__()");
                }
                (*$self)[i] = f;
            #endif
        }

        // tostring operator
        std::string __tostring() {
            std::stringstream str;
            for(glm::length_t i = 0; i < $self->length(); ++i) {
                str << (*$self)[i];
                if(i + 1 != $self->length()) {
                    str << " ";
                }
            }
            return str.str();
        }

        // extend operators, otherwise some languages (lua)
        // won't be able to act on objects directly (ie. v1 + v2)
        vec3 operator+(vec3 const & v) {return (*$self) + v;}
        vec3 operator+(float scalar) {return (*$self) + scalar;}
        vec3 operator-(vec3 const & v) {return (*$self) - v;}
        vec3 operator-(float scalar) {return (*$self) - scalar;}
        vec3 operator*(vec3 const & v) {return (*$self) * v;}
        vec3 operator*(float scalar) {return (*$self) * scalar;}
        vec3 operator/(vec3 const & v) {return (*$self) / v;}
        vec3 operator/(float scalar) {return (*$self) / scalar;}
        bool operator==(vec3 const & v) {return (*$self) == v;}
        bool operator!=(vec3 const & v) {return (*$self) != v;}
    };


    // VEC4
    //
    // -----------------------------------------------------------
    //
    struct vec4 {
    
        float x, y, z, w;

        static length_t length();

        vec4();
        vec4(vec4 const & v);
        vec4(float scalar);
        vec4(float s1, float s2, float s3, float s4);
        vec4(vec2 const & a, vec2 const & b);
        vec4(vec2 const & a, float b, float c);
        vec4(float a, vec2 const & b, float c);
        vec4(float a, float b, vec2 const & c);
        vec4(vec3 const & a, float b);
        vec4(float a, vec3 const & b);

        vec4 & operator=(vec4 const & v);
    };

    vec4 operator+(vec4 const & v, float scalar);
    vec4 operator+(float scalar, vec4 const & v);
    vec4 operator+(vec4 const & v1, vec4 const & v2);
    vec4 operator-(vec4 const & v, float scalar);
    vec4 operator-(float scalar, vec4 const & v);
    vec4 operator-(vec4 const & v1, vec4 const & v2);
    vec4 operator*(vec4 const & v, float scalar);
    vec4 operator*(float scalar, vec4 const & v);
    vec4 operator*(vec4 const & v1, vec4 const & v2);
    vec4 operator/(vec4 const & v, float scalar);
    vec4 operator/(float scalar, vec4 const & v);
    vec4 operator/(vec4 const & v1, vec4 const & v2);
    bool operator==(vec4 const & v1, vec4 const & v2);
    bool operator!=(vec4 const & v1, vec4 const & v2);

    %extend vec4 {

        // [] getter
        // out of bounds throws a string, which causes a Lua error
        float __getitem__(int i) throw (std::out_of_range) {
            #ifdef SWIGLUA
                if(i < 1 || i > $self->length()) {
                    throw std::out_of_range("in glm::vec4::__getitem__()");
                }
                return (*$self)[i-1];
            #else
                if(i < 0 || i >= $self->length()) {
                    throw std::out_of_range("in glm::vec4::__getitem__()");
                }
                return (*$self)[i];
            #endif
        }

        // [] setter
        // out of bounds throws a string, which causes a Lua error
        void __setitem__(int i, float f) throw (std::out_of_range) {
            #ifdef SWIGLUA
                if(i < 1 || i > $self->length()) {
                    throw std::out_of_range("in glm::vec4::__setitem__()");
                }
                (*$self)[i-1] = f;
            #else
                if(i < 0 || i >= $self->length()) {
                    throw std::out_of_range("in glm::vec4::__setitem__()");
                }
                (*$self)[i] = f;
            #endif
        }

        // tostring operator
        std::string __tostring() {
            std::stringstream str;
            for(glm::length_t i = 0; i < $self->length(); ++i) {
                str << (*$self)[i];
                if(i + 1 != $self->length()) {
                    str << " ";
                }
            }
            return str.str();
        }

        // extend operators, otherwise some languages (lua)
        // won't be able to act on objects directly (ie. v1 + v2)
        vec4 operator+(vec4 const & v) {return (*$self) + v;}
        vec4 operator+(float scalar) {return (*$self) + scalar;}
        vec4 operator-(vec4 const & v) {return (*$self) - v;}
        vec4 operator-(float scalar) {return (*$self) - scalar;}
        vec4 operator*(vec4 const & v) {return (*$self) * v;}
        vec4 operator*(float scalar) {return (*$self) * scalar;}
        vec4 operator/(vec4 const & v) {return (*$self) / v;}
        vec4 operator/(float scalar) {return (*$self) / scalar;}
        bool operator==(vec4 const & v) {return (*$self) == v;}
        bool operator!=(vec4 const & v) {return (*$self) != v;}
    };
}