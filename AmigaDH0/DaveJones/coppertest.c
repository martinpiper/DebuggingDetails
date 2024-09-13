/* **********************************************************************  */

/*     BACKGROUND SCREEN SHADING USING USER COPPER LISTS  - PAUL OVERAA    */

/* *************** GENERAL CONSTANT DEFINITION STATEMENTS **************** */

#define  INTUITION_VERSION    0      /* Zero's mean ANY library versions   */
#define  GRAPHICS_VERSION     0
#define  SCREENPLANES         4      /* Here we prepare to set up a high   */
#define  SCREENWIDTH          640    /* resolution Non-Interlaced screen   */
#define  SCREENHEIGHT         240    /* with 240 lines and 4 bitplanes.    */

/* *************************** INCLUDE FILES ***************************** */

#include <exec/types.h>
#include <exec/memory.h>
#include <intuition/intuition.h>
#include <graphics/gfxmacros.h>
#include <graphics/copper.h>
#include <hardware/custom.h>

/* ****************** STRUCTURES FOR SCREEN AND WINDOW ******************* */

struct NewScreen NewScreen = {
   0,0,           /* top left */
   SCREENWIDTH,SCREENHEIGHT, /* width and height */
   SCREENPLANES, /* depth, i.e. the number of bitplanes */
   1,0,          /* detail and block pens */
   HIRES,          /* ViewModes */
   CUSTOMSCREEN, 
   NULL,          /* Accept Default Font */
   NULL,          /* No Title */
   NULL,          /* No Gadgets */
   NULL,       /* Pointer to the bitmap structure */
};

struct NewWindow NewWindow = {
   0,0,   /* window XY origin relative to TopLeft of screen */
   SCREENWIDTH,SCREENHEIGHT, /* window width and height */
   -1,-1,   /* detail and block pens same as screen */
   NULL,   /* IDCMP flags */
   BORDERLESS,   /* other window flags */
   NULL,   /* first gadget in gadget list */
   NULL,   /* custom CHECKMARK imagery */
   NULL,   /* window title */
   NULL,   /* custom screen  */
   NULL,   /* custom bitmap */
   SCREENWIDTH,SCREENHEIGHT, /* minimum width and height */
   SCREENWIDTH,SCREENHEIGHT, /* maximum width and height */
   CUSTOMSCREEN   /* destination screen type */
};

/* *************** AMIGA RESOURCE "FUNCTION NUMBERS" ********************* */

#define  OPEN_INTUITION_LIBRARY    1
#define  OPEN_GRAPHICS_LIBRARY     2
#define  OPEN_CUSTOM_SCREEN        4
#define  OPEN_WINDOW               5

LONG  resource_vector[5] = {4,    /* count of operation labels to follow */
                            OPEN_INTUITION_LIBRARY,
                            OPEN_GRAPHICS_LIBRARY,
                            OPEN_CUSTOM_SCREEN,
                            OPEN_WINDOW
                           };

struct   IntuitionBase   *IntuitionBase;
struct   GfxBase         *GfxBase;
struct   Screen          *global_screen_p;
struct   Window          *global_window_p;
struct   ViewPort        *global_viewport_p;
struct   UCopList        *c;

extern struct Custom far custom;

main()

{

BOOL allocate_resource(),begin_block(); void end_block(); ULONG j,Blue=0;

if (begin_block()==TRUE) exit(FALSE); /* grab required resources or quit */

SetRGB4(global_viewport_p,0,0,0,0); 

/* allocate and initialize some memory for a user 
   copper list. I'll assume, for the purposes of this
   example, that the allocation won't fail... */

c=AllocMem(12L,MEMF_CHIP|MEMF_PUBLIC|MEMF_CLEAR); CINIT(c,800L);

/* here's the loop which sets up the user copper list... */

for (j=0;j<SCREENHEIGHT;j++)
   
   {
    
    (j/15) % 2 ? Blue-- : Blue++;
    
    CWAIT(c,j,0L);
    
    CMOVE(c,custom.color[0],Blue);
    
    }

CEND(c); global_viewport_p->UCopIns=c;

/* all we do now is re-do the display so the new
   copper list comes into effect... */

MakeScreen(global_screen_p); RethinkDisplay();

/* finally we quit after a delay of about 5 seconds */

Delay(250); 

end_block(); 

exit(TRUE); /* Logical end of the program */

}


/* ======================================================================= */
/* The following routines handle all the resources I need, ie they're      */
/* used to open and close libraries/screens etc.                           */ 
/* _______________________________________________________________________ */

BOOL begin_block()

{

LONG i,j; BOOL allocate_resource(),error_flag=FALSE;void deallocate_resource();

for (i=1;i<=resource_vector[0];i++)

      { error_flag=allocate_resource(resource_vector[i]);

        if (error_flag==TRUE)

            { for (j=i-1;j>0;j--){deallocate_resource(resource_vector[j]);}

              i=resource_vector[0]+1; /* force exit from 'i' loop */

            }
      }

return(error_flag);

}
/* _______________________________________________________________________ */

void end_block()

{

LONG i;

for(i=resource_vector[0];i>0;i--){deallocate_resource(resource_vector[i]);}

}
/* _______________________________________________________________________ */

BOOL allocate_resource(function_number)

LONG function_number;

{

BOOL error_flag=FALSE;

switch (function_number) {

         case OPEN_INTUITION_LIBRARY:

                  if((IntuitionBase=(struct IntuitionBase *)
                  OpenLibrary("intuition.library",INTUITION_VERSION))==NULL)
                   {error_flag=TRUE;}
                  break;

         case OPEN_GRAPHICS_LIBRARY:

                  if((GfxBase=(struct GfxBase *)
                  OpenLibrary("graphics.library",GRAPHICS_VERSION))==NULL)
                   {error_flag=TRUE;}
                  break;


         case OPEN_CUSTOM_SCREEN:

                  if((global_screen_p=(struct Screen *)OpenScreen(&NewScreen))==NULL)
                   {error_flag=TRUE;}
                   else {
                        global_viewport_p=&global_screen_p->ViewPort;
                        }
                   break;

         case  OPEN_WINDOW:

                  NewWindow.Screen=global_screen_p;
                  if((global_window_p=(struct Window *)OpenWindow(&NewWindow))==NULL)
                   {error_flag=TRUE;}
                   break;

         default: error_flag=TRUE; break;

                         }
return(error_flag);

}

/* ______________________________________________________________________ */

void deallocate_resource(function_number)

LONG function_number;

{

switch (function_number) {

      case OPEN_INTUITION_LIBRARY:  CloseLibrary(IntuitionBase); break;

      case OPEN_GRAPHICS_LIBRARY:   CloseLibrary(GfxBase); break;

      case OPEN_CUSTOM_SCREEN:      CloseScreen(global_screen_p); break;

      case OPEN_WINDOW:             CloseWindow(global_window_p); break;

      default:                      break;

                         }

}
/* ===================================================================== */



