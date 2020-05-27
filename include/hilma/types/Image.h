#pragma once

#include <memory>
#include <vector>
#include "glm/glm.hpp"

namespace hilma {

class Image {
public:

    Image();
    Image(const Image& _mother);
    Image(int _width, int _height, int _channels);
    Image(const uint8_t* _array3D, int _height, int _width, int _channels);
    
    virtual     ~Image();

    bool        allocate(size_t _width, size_t _height, size_t _channels);
    bool        isAllocated() const { return data.size() != 0; }

    int         getWidth() const { return width;}
    int         getHeight() const { return height;};
    int         getChannels() const { return channels;};

    size_t      getIndex(size_t _x, size_t _y) const { return (_y * width + _x) * channels; };
    size_t      getIndexUV(float _u, float _v) const { return getIndex(_u * width, _v * height); }

    void        set(const uint8_t* _array3D, int _height, int _width, int _channels);

    void        setValue(size_t _index, float _data);
    void        setValue(size_t _index, const float* _array1D, int _n);

    void        setColor(size_t _index, const glm::vec3& _color) { setValue( _index, &_color[0], 3); }
    void        setColor(size_t _index, const glm::vec4& _color) { setValue( _index, &_color[0], std::min(4, channels)); }

    void        setColors(const float* _array2D, int _m, int _n);

    void        get(uint8_t **_array3D, int *_height, int *_width, int *_channels);

    float       getValue(size_t _index) const;
    glm::vec4   getColor(size_t _index) const;

private:
    std::vector<float>  data;
    int                 width;
    int                 height;
    int                 channels;

    friend bool saveJpg( const std::string&, Image& );
    friend bool loadJpg( const std::string&, Image&, int );
    friend bool savePng( const std::string&, Image& );
    friend bool loadPng( const std::string&, Image&, int );
    friend bool saveHdr( const std::string&, Image& );
    friend bool loadHdr( const std::string&, Image&, int );

    friend void sdf(Image&);
    friend void flip(Image&);
    friend void sqrt(Image&);
    friend void invert(Image&);
    friend void autolevel(Image&);
    friend void gamma(Image&, float);
    friend void threshold(Image&, float);
    friend glm::vec2 getRange(const Image&);
    friend void remap(Image&, float, float, float, float, bool);
    friend Image denoise(const Image&, Image&, const Image&, bool);
};

typedef std::shared_ptr<Image> ImagePtr;
typedef std::shared_ptr<Image const> ImageConstPtr;

}