module.exports = function(grunt) {

  grunt.initConfig({
    bp: 'bower_components',
    ss: 'public/stylesheets',
    js: 'public/javascripts',
    pkg: grunt.file.readJSON('package.json'),

    // Task configuration
    less: {
        css: {
            options: {
              compress: false,  //minifying the result
            },
             files: {
                  "<%= ss %>/cms.css":"<%= ss %>/less/core/cms.less"
            }
        }
    },

    cssmin: {
      options: {
        banner: "/*! <%= pkg.name %> minified CSS file generated @ <%= grunt.template.today('dd-mm-yyyy') %> */\n"
      },
      css: {
        files: {
         "<%= ss %>/cms.min.css": [ "<%= ss %>/cms.css" ]
         }
      }
        },

    clean : {
      css : {
         src: ["<%= ss %>/cms.css", "<%= ss %>/cms.min.css"]
      },
      js: {
         src: ["<%= js %>/cms.js","<%= js %>/cms.min.js","<%= js %>/cms-admin.js","<%= js %>/cms-admin.min.js"]
      }
    },

    concat : {
      options: {
        separator: ';',
      },
      frontend: {
        src: [
          //jquery + bootstrap
          '<%= bp %>/jquery/dist/jquery.js',
          '<%= bp %>/bootstrap/dist/js/bootstrap.js',
          //Fullcalendar3
          '<%= bp %>/moment/min/moment-with-locales.js',
          '<%= bp %>/fullcalendar/dist/fullcalendar.js',
          '<%= bp %>/fullcalendar-scheduler/dist/scheduler.js',
          //Full Year Calendar
          '<%= bp %>/bootstrapyearcalendar/js/bootstrap-year-calendar.js',
          //recurrenceinput
          '<%= bp %>/recurrenceinput/lib/jquery.tmpl.js',
          '<%= bp %>/recurrenceinput/lib/jquery.tools.dateinput.js',
          '<%= bp %>/recurrenceinput/lib/jquery.tools.overlay.js',
          '<%= bp %>/recurrenceinput/src/jquery.recurrenceinput.js',
          //AdminLTE
          '<%= bp %>/AdminLTE/dist/js/app.js',
          '<%= bp %>/AdminLTE/plugins/datepicker/bootstrap-datepicker.js',
          '<%= bp %>/AdminLTE/plugins/fastclick/fastclick.js',
          '<%= bp %>/AdminLTE/plugins/slimScroll/jquery.slimscroll.js',
          '<%= bp %>/AdminLTE/plugins/timepicker/bootstrap-timepicker.js',
          '<%= bp %>/AdminLTE/plugins/select2/select2.full.js',
          //RBS
          '<%= js %>/main.js' 
        ],
        dest: '<%= js %>/cms.js'
      }
    },



    jshint: {
      options: {
        curly: true,
        eqeqeq: true,
        eqnull: true,
        browser: true,
        globals: {
          jQuery: true
        },
      },
      all: ['Gruntfile.js', '<%= js %>/main.js']
    },

    uglify : {
      frontend: {
        files: {
          '<%= js %>/cms.min.js' : [ '<%= js %>/cms.js' ]
        }
      }
    },

    imagemin: {
    png: {
      options: {
        optimizationLevel: 7
      },
      files: [
        {
          // Set to true to enable the following options…
          expand: true,
          // cwd is 'current working directory'
          cwd: 'public/images/',
          src: ['**/*.png'],
          // Could also match cwd line above. i.e. project-directory/img/
          dest: 'public/images/',
          ext: '.png'
        }
      ]
    },
    jpg: {
      options: {
        progressive: true
      },
      files: [
        {
          // Set to true to enable the following options…
          expand: true,
          // cwd is 'current working directory'
          cwd: 'public/images/',
          src: ['**/*.jpg'],
          // Could also match cwd. i.e. project-directory/img/
          dest: 'public/images/',
          ext: '.jpg'
        }
      ]
    }
  } ,

    watch: {
      js: {
        files: ['<%= js %>/backend.js', '<%= js %>/frontend.js'],
        tasks: ['js']
      },
      css: {
        files: ['<%= ss %>/less/core/*.less', '<%= ss %>/less/site/*.less'],
        tasks: ['css']
      }
    },

  replace: {
      dist: {
        options: {
          patterns: [
            {
              match: "url('fonts/",
              replacement: "url('/stylesheets/fonts/"
            },
            {
              match: "url('../img/",
              replacement: "url('/images/"
            }
          ],
          usePrefix: false
        },
        files: [
          {expand: true, flatten: true, src: ['<%= ss %>/cms.css'], dest: '<%= ss %>'}
        ]
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-replace');
  grunt.loadNpmTasks('grunt-rev');

  grunt.registerTask('css', ['clean:css', 'less:css','replace','cssmin:css']);
  grunt.registerTask('js', ['jshint', 'clean:js', 'concat', 'uglify']);
  grunt.registerTask('default', ['watch']);
};
