
module.exports = {
  content: ["./index.html", "./src/**/*.{vue,js,ts,jsx,tsx}", "./node_modules/tw-elements/dist/js/**/*.js"],
  darkMode: 'class', // or 'media' or 'class'
  theme: {
    extend: { 
      fontSize: { 
        'xt': '.60rem',
        'xxt': '.50rem',
        'ty': '.68rem',
      },
      colors: {
        primary: {
          light: '#E53935',
          whitish: '#e7f3cf',
          dark: '#E53935'
        }, 
        accent: {
          light: '#F44336',
          dark: '#F44336',
          lightish: '#def2f2'
        },
        card: {
          light: '#FFEBEE',
          dark: '#3b3b3b',
          lightish: '#f1f3fd'
        },
        accentlight: {
          light: '#f1f3fd',
          dark: '#3b3b3b',
          lightish: '#f1f3fd'
        },
        primaryDark:{
          light: '#C62828',
          dark: '#C62828'
        },
        icon:{
          light: '#333333',
          lightish: '#333333',
          dark: '#EEEEEE',
          darkish: '#DDDDDD'
        },
        background:{
          light: '#ffffff',
          lightish: '#F8F9FE',
          dark: '#303030',
          darkish: '#424242',
          deepdark: '#212121',
        },
        sidebar:{
          light:'#ffffff',
          dark:'#2b2b2b',
        },
        success: {
          light: '#7EA629',
          dark: '#70912a'
        },
        error: {
          light: '#b71c1c',
          dark: '#b71c1c'
        },
        warnning: {
          light: '#ff9800',
          dark: '#ff9800'
        },
        warning: {
          light: '#ff9800',
          dark: '#ff9800'
        },
        cancel: {
          light: '#bf360c',
          dark: '#a63412'
        }
      },
      gridTemplateColumns: { 
        '16': 'repeat(16, minmax(0, 1fr))',
        '20': 'repeat(20, minmax(0, 1fr))'
      },
      fontFamily: {
        'helvatica': ['Helvetica' ],
      },
      gridColumn: {
        'span-13': 'span 13 / span 13',
        'span-14': 'span 14 / span 14',
        'span-15': 'span 15 / span 15',
        'span-16': 'span 16 / span 16',

        'span-17': 'span 17 / span 17',
        'span-18': 'span 18 / span 18',
        'span-19': 'span 19 / span 19',
        'span-20': 'span 20 / span 20',
      },
      width: { 
        '1/7': '14.2857143%',
        '11/50': '22%',
        '39/50': '78%', 
        '6/7': '85.7142857%',
      },
      gridColumnStart: {
        '13': '13',
        '14': '14',
        '15': '15',
        '16': '16',
       }
    }
  },  
  plugins: [require("tw-elements/dist/plugin.cjs")],
};
