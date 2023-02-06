# 2022 Signal Processing Exam - 20193387 Thomas Møller Jensen
I'm not expecting to pass the first exam, but i'd still like to know how far i can get in the exam.


## A.1
A continuous-time filter is given by the transfer function $H_c(s):$

$$H_c(s)=\frac{s+1}{s²+5s+6}$$

We want to design the corresponding discrete-time filter $H(z)$ using the Impulse Invariant Method

The impulse invariant method is a proceedure that usually looks somewhat like this:

$$H(z)=\mathcal{L}^{-1}\{H_c(s)\}\lArr sample \lArr \mathcal{Z}\{h[n]\}$$

**Find a closed-form expression for the continuous-time impulse response $h_c(t)$. Assume that the continuous-time system is causal. Hint: You may want to first decompose $H_c(s)$ into two 1st order sections using Partial Fraction Expansion.**

Since the system is causal we know that the system will be multiplied by the signal $u(t)$ which is the unit step function, it is defined as $u[n]=\{^{1 : x > 0}_{0 : otherwise}$

The result is found by taking the inverse laplace transform:

$$h_c(t)=\mathcal{L}^{-1}\{H_c(s)\}$$

I can't really find any notes for partial fraction expansion and i can't find a laplace transform in a table that solves the laplace transform so i will be calculating this using mathcad:

Mathcad gives me a result that doesn't look correct so i'm kinda giving up on this exercise...



****
## A.2
A discrete-time filter $H(z)$ is specified by two zeros in $z= 0$ and $z= 0.8966$, respectively, and two poles in $z= 0.8197$ and $z= 0.7399$, respectively.

**Draw a figure showing the pole-zero diagram.**

I will be using drawio to draw this figure

<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="354px" viewBox="-0.5 -0.5 354 344" content="&lt;mxfile host=&quot;0opvc9ch9219fk9j4p0cpisfbsmtn3i4sbt671u1b7gejltpbfor&quot; modified=&quot;2023-01-04T09:53:03.437Z&quot; agent=&quot;Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.71.0 Chrome/102.0.5005.167 Electron/19.0.12 Safari/537.36&quot; etag=&quot;z7FlVCHXajWLbEjwq1GL&quot; version=&quot;12.2.4&quot; pages=&quot;1&quot;&gt;&lt;diagram id=&quot;V2kcJ_vxxj7O8LxIPm2B&quot; name=&quot;Page-1&quot;&gt;zZdNj9sgEIZ/TY67MmA78XGT3W57qFQ1hx5XyCY2KjYWJl/764trsAM42ijK1yWCFxiGZ4YxmaBFuXsXuC5+8oywCQyy3QS9TiBEMFa/rbDvhDAOOyEXNOskMAhL+km0GGh1TTPSWBMl50zS2hZTXlUklZaGheBbe9qKM3vXGufEE5YpZr76h2ay6NQZnA76d0LzwuwM4qQbKbGZrE/SFDjj2wMJvU3QQnAuu1a5WxDWsjNcunXfjoz2jglSyVMWRN2CDWZrfTbtl9ybw6oFiqvqzLcFlWRZ47Qd2arIKq2QJVM9oJq4qTvYK7ojyv7cd0b7tyFCkt2BpJ17J7wkUuzVFDNqQOlMAbHubwfuvVYcMjci1rHOe9sDDtXQRMbpQI/Ob+LzqbKXNqdUL2W4aWhqYzlKgWRWlh1nYBGAPoBo5PxGE4RhSTd24o4x0dv/4lS52e8d2vj7vrHQ8LVIiV50mGeOHRR/YUhikRP5tSEnH6Bjhq9WDbEs/I9xD/WksCMv7D/Ke4f9ySTjbeIOA5tzGJwZeNfQ7My4P0EbB7hG4GcPXg376JrsR34xgCNJ4d6Sc2ph8uhsgPOliG7Hxmz9uHCc8guS6GZw4gdnA5L7XSrgw/n8CFQj8Bip00gbRiMF/0sWnHGhlIpXLcAVZcyRMKN51X6mFCOi9HnLhqrX7IseKGmWsWP0BV9XWcta+XQZ3u5TAPi8w2vx9it8/QHasz1PUZKcAP0Sl3HmXkYfwDTyAaBLAPDLuE6451kSxzcC4JRqOFKqk5EMuASAkTf9HTIARXYGhFcDoLrDv8nuSTT8JUdv/wA=&lt;/diagram&gt;&lt;/mxfile&gt;" onclick="(function(svg){var src=window.event.target||window.event.srcElement;while (src!=null&amp;&amp;src.nodeName.toLowerCase()!='a'){src=src.parentNode;}if(src==null){if(svg.wnd!=null&amp;&amp;!svg.wnd.closed){svg.wnd.focus();}else{var r=function(evt){if(evt.data=='ready'&amp;&amp;evt.source==svg.wnd){svg.wnd.postMessage(decodeURIComponent(svg.getAttribute('content')),'*');window.removeEventListener('message',r);}};window.addEventListener('message',r);svg.wnd=window.open('https://www.draw.io/?client=1&amp;lightbox=1&amp;edit=_blank');}}})(this);" style="cursor:pointer;max-width:100%;max-height:344px;"><defs/><g><ellipse cx="167" cy="175" rx="80" ry="80" fill="#ffffff" stroke="#000000" pointer-events="all"/><path d="M 7 175 L 320.63 175" fill="none" stroke="#000000" stroke-miterlimit="10" pointer-events="stroke"/><path d="M 325.88 175 L 318.88 178.5 L 320.63 175 L 318.88 171.5 Z" fill="#000000" stroke="#000000" stroke-miterlimit="10" pointer-events="all"/><g transform="translate(340.5,169.5)"><foreignObject style="overflow:visible;" pointer-events="all" width="13" height="11"><div xmlns="http://www.w3.org/1999/xhtml" style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; vertical-align: top; white-space: nowrap; text-align: center;"><div xmlns="http://www.w3.org/1999/xhtml" style="display:inline-block;text-align:inherit;text-decoration:inherit;background-color:#ffffff;">Re</div></div></foreignObject></g><path d="M 167 335 L 167 21.37" fill="none" stroke="#000000" stroke-miterlimit="10" pointer-events="stroke"/><path d="M 167 16.12 L 170.5 23.12 L 167 21.37 L 163.5 23.12 Z" fill="#000000" stroke="#000000" stroke-miterlimit="10" pointer-events="all"/><g transform="translate(179.5,-0.5)"><foreignObject style="overflow:visible;" pointer-events="all" width="14" height="11"><div xmlns="http://www.w3.org/1999/xhtml" style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; vertical-align: top; white-space: nowrap; text-align: center;"><div xmlns="http://www.w3.org/1999/xhtml" style="display:inline-block;text-align:inherit;text-decoration:inherit;background-color:#ffffff;">Im</div></div></foreignObject></g><ellipse cx="227" cy="175" rx="10" ry="10" fill="#ffffff" stroke="#000000" pointer-events="all"/><ellipse cx="187" cy="95" rx="10" ry="10" fill="#ffffff" stroke="#000000" pointer-events="all"/><ellipse cx="237" cy="140" rx="10" ry="10" fill="#ffffff" stroke="#000000" pointer-events="all"/><ellipse cx="167" cy="175" rx="10" ry="10" fill="#ffffff" stroke="#000000" pointer-events="all"/><rect x="127" y="145" width="40" height="20" fill="none" stroke="none" pointer-events="all"/><g transform="translate(130.5,148.5)"><foreignObject style="overflow:visible;" pointer-events="all" width="32" height="12"><div xmlns="http://www.w3.org/1999/xhtml" style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; vertical-align: top; width: 33px; white-space: nowrap; overflow-wrap: normal; text-align: center;"><div xmlns="http://www.w3.org/1999/xhtml" style="display:inline-block;text-align:inherit;text-decoration:inherit;white-space:normal;">z_0=0</div></div></foreignObject></g><rect x="247" y="125" width="75" height="30" fill="none" stroke="none" pointer-events="all"/><g transform="translate(248.5,131.5)"><foreignObject style="overflow:visible;" pointer-events="all" width="64" height="12"><div xmlns="http://www.w3.org/1999/xhtml" style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; vertical-align: top; white-space: nowrap; text-align: left;"><div xmlns="http://www.w3.org/1999/xhtml" style="display:inline-block;text-align:inherit;text-decoration:inherit;">p_1=0.7399</div></div></foreignObject></g><rect x="177" y="185" width="90" height="30" fill="none" stroke="none" pointer-events="all"/><g transform="translate(178.5,191.5)"><foreignObject style="overflow:visible;" pointer-events="all" width="62" height="12"><div xmlns="http://www.w3.org/1999/xhtml" style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; vertical-align: top; white-space: nowrap; text-align: left;"><div xmlns="http://www.w3.org/1999/xhtml" style="display:inline-block;text-align:inherit;text-decoration:inherit;">z_0=0.8966</div></div></foreignObject></g><rect x="202" y="75" width="90" height="30" fill="none" stroke="none" pointer-events="all"/><g transform="translate(203.5,81.5)"><foreignObject style="overflow:visible;" pointer-events="all" width="64" height="12"><div xmlns="http://www.w3.org/1999/xhtml" style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; vertical-align: top; white-space: nowrap; text-align: left;"><div xmlns="http://www.w3.org/1999/xhtml" style="display:inline-block;text-align:inherit;text-decoration:inherit;">p_1=0.7399</div></div></foreignObject></g></g></svg>

It was made quickly so it isn't very pretty but basicly the circle is supposed to be the unit circle where the zeros should be along the real axis and the poles should just be within the unit circle in the z-plane.

**Decide whether the filter is of type IIR or FIR. Argue your answer.**

I'm not that sure but i have an idea that the transfer function of this filter can look somewhat like this:

$$H(s)=\frac{Y(z)}{X(z)}=\frac{1+z_1z^{-1}+z_2z^{-2}}{1+p_1z^{-1}+p_2z^{-2}}$$

As there is two poles and two zeros and transfer functions usually look like this. with the values from the previous part we can get th final transfer function:

$$H(s)=\frac{1+0.8966z^{-2}}{1+0.8197z^{-1}+0.7399z^{-2}}$$

the filter is a FIR filter if the phase response has a linear phase response, the phase response is defined as follows:

$$Arg(H(j\Omega))$$

Linear phase means that the phase response is the equation for a straight line.

where $j\Omega$ is defined as the imaginary part of s. otherwise usually denoted as the phase.

I can't really find the definition of an IIR filter but i'm guessing its something like an Impulse Invariant Filter? if so i presume that we can find out whether the filter is an IIR filter or not by using the impulse invariant method.



****
## A.3

An $M^{th}$ order Type I FIR filter should be designed using the Window Method. The desired (i.e., the ideal) impulse response of the filter is:

$$h_d[n]=\frac{sin\{(n-\frac{M}{2})\cdot \frac{\pi}{5}\}}{(n-\frac{M}{2})\cdot \pi} : -\infty < n < \infty$$


**Calculate the impulse response $ℎ[n]$ for $M= 6$ using the Hamming window. Give the result with 4 decimals. Hint: Use L’Hopital’s rule for $n= 3$.**

I'm guessing that the hamming window is the window method described in the lectures.

The definition of the window function is the following: 

$$H(e^{j\Omega})=\left(h\left[\frac{M}{2}\right]+2\sum_{k=1}^{\frac{M}{2}}h\left[\frac{M}{2}+k\right]\cos(\omega k)\right)e^{\frac{j\omega M}{2}}$$

Looking at the exercise again, i notice it wants the impulse response $h_c(t)$



****
**B.1**


****
**B.2**