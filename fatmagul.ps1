<#
.SYNOPSIS
Download Fatmagul (Spanish) from Mega. I didn't share them. I just found them here: http://fatmagulnovelaturca.blogspot.com/
.DESCRIPTION
I've saved all the mega_urls in case the site changes. I can just switch to that. 
I browse the site, to travers all his 'adf.ly' links though so the sharer might get the ad-credit he desires.

*Important*:
This does not validate and re-download in case your download didn't finish. If the file exists, the download is skipped.
I had two episodes that didn't download completely. I just deleted those and re-ran this script to get them again.
.PARAMETER MegaDL
The path to the `megadl.exe`. Must be a [PathInfo] Object; see examples.
.PARAMETER DownloadTo
The path to download to. Must be a [PathInfo] Object; see examples.
.PARAMETER UsePreSavedMegaUrls
If this switch is set, the previously acquired Mega URLS will be used.

Otherwise, the blog will be parsed and will look at all the 'adf.ly' links to get the Mega URLs. This might help the OP get ad credit ... /shrug
.EXAMPLE
$MegaDL = (Resolve-Path "..\megatools-1.9.97-win64\megadl.exe")
$DownloadTo = (Resolve-Path "..\Fatmagul")
.\fatmagul.ps1 -MegaDL $MegaDL -DownloadTo $DownloadTo -Verbose
.NOTES
You will need MegaTools (https://megatools.megous.com).
.LINK
http://fatmagulnovelaturca.blogspot.com/
#>
[CmdletBinding()]
param(
    [Parameter(
        Position=0,
        HelpMessage="Path to 'megadl.exe'. Download MegaTools from: https://megatools.megous.com"
    )]
    [System.Management.Automation.PathInfo]
    $MegaDL = (Resolve-Path "$(Split-Path $PSScriptRoot -Parent)\megatools-1.9.97-win64\megadl.exe")
    ,
    [Parameter(
        Position=1,
        HelpMessage="Path to download the files to."
    )]
    [System.Management.Automation.PathInfo]
    $DownloadTo = (Resolve-Path "$(Split-Path $PSScriptRoot -Parent)\Media\TV\Fatmagul")
    ,
    [switch]
    $UsePreSavedMegaUrls
)

# To help the OP since you want his wares, click a few of the Adf.ly links
Start-Process 'http://fatmagulnovelaturca.blogspot.com'

function Get-FatmagulMegaUrls () {
    [CmdletBinding()]
    param(
        [switch]
        $UsePreSavedMegaUrls = $UsePreSavedMegaUrls
    )


    if ($UsePreSavedMegaUrls) {
        # These are pre-saved from the blog...
        $mega_urls = @{
            'fatmagulcap001' = 'https://mega.nz/#!XIp3zJSL!-vondqtE-EP98vgwyHKk5sOuBx2VRdxjzckPvY3Su1I';
            'fatmagulcap002' = 'https://mega.nz/#!bRAGnRyA!MctE0l-hdJVIRGK-taQT-bf5fMOdHdhDLL-5B8zjcoQ';
            'fatmagulcap003' = 'https://mega.nz/#!DY5wzJJS!jamJDia6ZPQ0LmITnQtYh4bwhxxleqCDFzTUFhG6NYU';
            'fatmagulcap004' = 'https://mega.nz/#!SIBHnCTI!OhueNlyczoLe_3_4rGGnHXGmJKEKeKknTU_n88eEqEk';
            'fatmagulcap005' = 'https://mega.nz/#!2JZFVAzZ!5AtQ5zvcnUOLYUt8Doo2NVI-XMUPjL2NMupPFb-kWxI';
            'fatmagulcap006' = 'https://mega.nz/#!iZwhUQSR!BzNJ28lu-BIy_8hdOIzRc-7j8f8Y8BMbd_6RqQIviAE';
            'fatmagulcap007' = 'https://mega.nz/#!uYpUjYII!MB83hNMdGAWnBWI1vT4N46G__KuLubw2JgsJXd-8JlE';
            'fatmagulcap008' = 'https://mega.nz/#!jQB1BJbB!RTjOTXUVe1v_NVqjt6tjwEh3_xZpppM2wRc_zuJoZRo';
            'fatmagulcap009' = 'https://mega.nz/#!2YImzI4D!fGtf7JVpEJrekL1UQmAN45HDalD3ZQ2Me54bzZNdiDg';
            'fatmagulcap010' = 'https://mega.nz/#!6MhATbZB!bQkwNBBkI9xZuCA-z3fJS7W0BGk3vTZxnhmAksKMHXE';
            'fatmagulcap011' = 'https://mega.nz/#!qER0CLLR!KW-iCsyIHiFCuhAyi5urN_r_51etiGFO5taeWqE6EJY';
            'fatmagulcap012' = 'https://mega.nz/#!GAYTXZqC!cjBvcp-prJ23vy1haPU6eRE2Ma9I73MCJLdVbP23XmY';
            'fatmagulcap013' = 'https://mega.nz/#!qcgj1JaC!SK02uixfDfMRr54n0094MXI485V3uEqoS6BD9exreXk';
            'fatmagulcap014' = 'https://mega.nz/#!7VQxyDLb!oN4phPbWC52M7l1DSDZZcxlJ1edoAtc3PfdQEFbDRlQ';
            'fatmagulcap015' = 'https://mega.nz/#!iAA2VZYb!V8T0fOi685EZwdJFpjTLOPiqoXOU9MCBMBMdQx4_4Ho';
            'fatmagulcap016' = 'https://mega.nz/#!XEhGkAaZ!cdg8WW6bqyR5xRNWj1NHWF2bgfeg5XGyU1RZL3aI3-Q';
            'fatmagulcap017' = 'https://mega.nz/#!SYgnUYTS!WEs5AT1j029DWbsQ5mhtX-06hZl--6Uonj2siUa6Qqg';
            'fatmagulcap018' = 'https://mega.nz/#!HQQEiAjT!cQlJjDQRMfMi_R4YrRQVISqnxOfWQXXtsLa1xVyYVmw';
            'fatmagulcap019' = 'https://mega.nz/#!XcghHDRQ!3LOKaFKKzPPqeN_trYn5bxzX3tq5MvmZ3iNpaiA1fA8';
            'fatmagulcap020' = 'https://mega.nz/#!TMpQ3TZa!Qnc6_wxm494xfNKG3VbO8wP7BhnI5iyCvC-rnofLx34';
            'fatmagulcap021' = 'https://mega.nz/#!yE5mTS5J!ZPI1XlU5H_uzTRi22aXkHrv3ZLzhMuJ2kHCCvs4GS7Y';
            'fatmagulcap022' = 'https://mega.nz/#!bYpzzJ4K!CRGOnVSF1hAiNHyEjsMYidE69Z_e-qnCJAcd9aQd0qw';
            'fatmagulcap023' = 'https://mega.nz/#!OZAQGBwa!OiZe63mu2xGQdiim888n52Aa91UmKsUxZs0-UJUAnq4';
            'fatmagulcap024' = 'https://mega.nz/#!iEJzjIpQ!su8z57ZS8iMT-O3ubyeCJtk7NbmjiHYKDikCUn4UbVQ';
            'fatmagulcap025' = 'https://mega.nz/#!iJxHkDrY!33FXqDCTWsARtXlAsKa7g__0Yv9nrPyh4b5_iDIbXbg';
            'fatmagulcap026' = 'https://mega.nz/#!mRZhSKbb!ggTFXyn_bv1a4cx6LRLRBZ9aqFFLW8RLA4u8iBWUSsY';
            'fatmagulcap027' = 'https://mega.nz/#!uJZFhJLT!Or7rsZRHZJIM6iJZUm6PmzTW5jl81qwFekWHTHPa5XE';
            'fatmagulcap028' = 'https://mega.nz/#!Sd4SkTab!S28bzSeZ-DjELpqJsdHidyWDlG1t7niRnuxssQHwRKA';
            'fatmagulcap029' = 'https://mega.nz/#!ecZ0HAgD!aCNbGzlMbYU4RTraPObteOs9QszfsZiPEJJY5S46ZGs';
            'fatmagulcap030' = 'https://mega.nz/#!LQATXabY!CzEawQiSWoUUciRDjipjDOpHNG2qaWhbNi6Cfq7vRiQ';
            'fatmagulcap031' = 'https://mega.nz/#!GFAx3CLD!Kfdprp6-b4AdL_4F30JgySsBLis-VLgEO5KcceJ-o0I';
            'fatmagulcap032' = 'https://mega.nz/#!3R5TwQKb!v_LE1fQOpLo22uXga7EFi7n8dkjC3JblrbvW6d3tgEE';
            'fatmagulcap033' = 'https://mega.nz/#!iBwWEYaK!tNvzwafBQQFhVsCeYJY0kmlCvFIzoN2-6JrBmMyv90A';
            'fatmagulcap034' = 'https://mega.nz/#!WJBXAbaZ!LbDwnZM5atL09CU-GNDrx462RhoTN35RRRgAhkFA6Dg';
            'fatmagulcap035' = 'https://mega.nz/#!OMoV1IwZ!lAAS0JSca15WkyqdKPV2GvYaul9brEerWbSNQuhVgxE';
            'fatmagulcap036' = 'https://mega.nz/#!2IJ2kKhA!_EYs8IEPiD-rKxbKX2TrJIuWPDG3rwb8jSCrY3TucE4';
            'fatmagulcap037' = 'https://mega.nz/#!vMg00SIZ!5mc4zj-RXS_zbjl4cL8ieJLW6Rx1rLuSdXHWerX1mdY';
            'fatmagulcap038' = 'https://mega.nz/#!TEhgCCpB!cmEMX-nnWSfPUgjUwKPqHKeDP_2sY25g-4mwUclNg5k';
            'fatmagulcap039' = 'https://mega.nz/#!jd5XATDC!IsP6wsac_JtpC8GuLFIJrQqYIEdGmAgA_P0bxRx7hGY';
            'fatmagulcap040' = 'https://mega.nz/#!LcYzGbyK!9IhHqwu28iPXeIZZl_vjKaSwUhgZ7LZQhmXehclZ5N4';
            'fatmagulcap041' = 'https://mega.nz/#!DEwgDA6a!urwWzu-AJxViKl9RzK6WaSDn5aDuQ6MyXO_4iORsZGQ';
            'fatmagulcap042' = 'https://mega.nz/#!6cYU0QhJ!e_oBLbI8-ZGnrh5kcYrLba5LmvcqgGRFB8ruOSUifto';
            'fatmagulcap043' = 'https://mega.nz/#!GdZ1yarT!kNjdgCYUb68nq0VR5eZ-Y2FRjo9vb3lmuf7DSz3YV5g';
            'fatmagulcap044' = 'https://mega.nz/#!fEgVlB4R!v0UALMH531V67kEmKcuNNWsEUcmp08CPjsx534IPtXM';
            'fatmagulcap045' = 'https://mega.nz/#!XMhnkQLL!jd5WtvjPQkveLrWVmwCyhMli2QGx3tVimFDrZdOAG7I';
            'fatmagulcap046' = 'https://mega.nz/#!GN4BjBQY!QOqjXGqx8ejzbf0mgvIJTFVt14Bluc0oFBi_l39kOCk';
            'fatmagulcap047' = 'https://mega.nz/#!zYZnyIbI!4Rj82jX4Vi7Rfdj4pMqj-d2El8-I9FEdqlEEhNY06ws';
            'fatmagulcap048' = 'https://mega.nz/#!bZY0iIKL!ShzJFuFHPV_61WsQbocXI6swKxE6h6V_JG4FR1s58uE';
            'fatmagulcap049' = 'https://mega.nz/#!TRYmCB5L!plOXV02OmI7pQFpYgDf_-Gqtgvp1D_p4Tix78W7jOiY';
            'fatmagulcap050' = 'https://mega.nz/#!CZJmDZBJ!1fLDr5tsBmHhLIq5s862EM_5MuIhqJCQMTHrmVeQiwQ';
            'fatmagulcap051' = 'https://mega.nz/#!ngtCFJSA!AWpW2g6ZN3QadtuwwbfmFh-g8TN3Ek_cgXlGSORX7e0';
            'fatmagulcap052' = 'https://mega.nz/#!qQ5FVbbS!ZO2VQwD8sziMMIIdsIVPzMzEqpdlCkhmXFA0MANe1x8';
            'fatmagulcap053' = 'https://mega.nz/#!XU5x3A6B!XpcdsTVZpsMFJlQSExZk8gxgG183PB06D13lPRJ5z_Q';
            'fatmagulcap054' = 'https://mega.nz/#!aM4HkaLR!LpnBvbQXeCT43uYshdgTF7DwZAtm-ZCTa8nUm_S1A0U';
            'fatmagulcap055' = 'https://mega.nz/#!2MxGSSob!DFMboynS1HDibZ0P2iwe4cG93TpOFFxCDxHCT0ubhm0';
            'fatmagulcap056' = 'https://mega.nz/#!mYYhkZbR!gSkqq5Jjk37FeesO3ikta6y9HsTrqnKAdGpplFYLA8A';
            'fatmagulcap057' = 'https://mega.nz/#!SR5B2Zxb!To0_Mg9sDxcXOl0vsI9FH1jrtpqC654jvSofShXw4Lc';
            'fatmagulcap058' = 'https://mega.nz/#!XB4HSKgR!A_-CRixeULmopydC5cre_wMOnJ-4QOwuqs3J3CZX7Ow';
            'fatmagulcap059' = 'https://mega.nz/#!ScJy3LDD!rkLPIzsGPTqDV1yUqDtDiBAe7L5-N09rnePAQKFDJ08';
            'fatmagulcap060' = 'https://mega.nz/#!jcx1CSjb!a0zCf-uM3J5GYpb4QGAwZsyYApgKZMF75XdMC8ISmC0';
            'fatmagulcap061' = 'https://mega.nz/#!OV50mLzY!JCcmvDispepDvW1e2hEi84pxjgydGqyMFYtVJjWhGDw';
            'fatmagulcap062' = 'https://mega.nz/#!SZh3xJSR!FOo7BmdTuZrYqb-DmI-1RFO22ijyb10Vk_6VwfDJs3I';
            'fatmagulcap063' = 'https://mega.nz/#!OdAUAJBT!7UDT6x8-_YJeHd5DgIx168qAkjQVdSUuIHohNx6GaBo';
            'fatmagulcap064' = 'https://mega.nz/#!fcpQQCSA!50pJpvqO7pkMZPjeNhOLLMQy7Kw0T_HqdpizalnPxzU';
            'fatmagulcap065' = 'https://mega.nz/#!DRR0FaKR!kdgwVsAmgYbo6eZ7fHjVh0Z-9yL06NPjYEgqkqlAGGk';
            'fatmagulcap066' = 'https://mega.nz/#!PAxQjBrD!wLzdEDP10w9_seV9RxBPD3KjZWfeMkSidUv8zu6SJvQ';
            'fatmagulcap067' = 'https://mega.nz/#!zcAgQTRZ!v5O03OVL_9vTQChAT5r-23G4dKJaNSljPAX-0hHF71M';
            'fatmagulcap068' = 'https://mega.nz/#!3R5yxYSA!Ibf-XuhCWehZigo1Q0s6APGuk-anCAPn70hW3R6Ov6c';
            'fatmagulcap069' = 'https://mega.nz/#!3QQRURiQ!k3It6jLKlNYQMpPUg1fofVkyPcQ52FPox1dW8CUXpfY';
            'fatmagulcap070' = 'https://mega.nz/#!fRx1RTwB!xRUKAteeNhb_qcCYWYkvxGXD9LDriQaB_ow2RyqAbvo';
            'fatmagulcap071' = 'https://mega.nz/#!yZ5WlSQZ!QGJnXKSWImQhcmPSq9J3ecSt96At3Gfg9yUY369Neyc';
            'fatmagulcap072' = 'https://mega.nz/#!zJJm1baB!THiY-T7RJ4gtufjJ981kigiTkz7V-5lG__RDz4noqCA';
            'fatmagulcap073' = 'https://mega.nz/#!yNImiBjB!-Q0vPy1iu_fMCyKLWTUSoFrq6Y1oJu7gynjinFZgSWU';
            'fatmagulcap074' = 'https://mega.nz/#!SBI3hRJa!asWNoCv5ISG9kkZ9v0aAJrlh_tNQDkDAcTwPCqER3FY';
            'fatmagulcap075' = 'https://mega.nz/#!OYxhQIaY!gNwCu3mKg7gLyfvMPC-39cU1CIGxE8zwmWQv6dBAVZE';
            'fatmagulcap076' = 'https://mega.nz/#!rUx1kBCB!BJVy9q8WpXibOGO-TDufWePHuXM9hxPnw2_CX3tA7FU';
            'fatmagulcap077' = 'https://mega.nz/#!6NQ1yDSC!WdxxqsTkEuhDqAN78nsZZ3AneLso9BKwsnGKt6JAwRM';
            'fatmagulcap078' = 'https://mega.nz/#!HIRkmIxK!xMSjQUQx5gOICwozdfRhVQIlqOs6WTchBdPaNhMQ6qc';
            'fatmagulcap079' = 'https://mega.nz/#!uFADWDxL!lAqyccO0RRleourwPovpIeCFr_jZYMosPbIeHtZ6wLE';
            'fatmagulcap080' = 'https://mega.nz/#!CNoAWIiA!W-VSevkZ4v1Giu1WIFx2kYYPjXbqgkP06f9Gw6HYAKg';
            'fatmagulcap081' = 'https://mega.nz/#!HVBSUCAY!nDqIzqWRaCCUvPrgdhiDGNyCjsstxaY3YnOOsJbRgQ0';
            'fatmagulcap082' = 'https://mega.nz/#!qdJADZLR!iN0Ahx6AzAdQ0pvcAR9QjnElMZ4RCBOjHFuz9RwvA_A';
            'fatmagulcap083' = 'https://mega.nz/#!eFQREaya!RbDDts5NtOBEvttWqXm-lemGzT_HmYimVyHWjeo2btA';
            'fatmagulcap084' = 'https://mega.nz/#!aNJEjKIZ!8RO24VAQInUFoQdU2WvbkOXwxl5sRAi63Yjv3XNG2iY';
            'fatmagulcap085' = 'https://mega.nz/#!TJRxFJJD!UxYsBaarjMcAHYO-aqH1k7JIHb1W9qCmOsywPlFot6Y';
            'fatmagulcap086' = 'https://mega.nz/#!jJIjibJY!PzqYH4GLlD-HcwID8Yo8JYvo4xVVyLu44FRqxcOxADA';
            'fatmagulcap087' = 'https://mega.nz/#!qFBiFIID!Bgx_5EjolghRjKD-RvWyXDJHOU07726o6WPyYR_yPFY';
            'fatmagulcap088' = 'https://mega.nz/#!TIwUzLoJ!VrqsDhRP5wLaRroEOmTKs-38Pj-7dDjNG5TA4-mjMDM';
            'fatmagulcap089' = 'https://mega.nz/#!KdABma5D!YY017TXEnj1tqT40578SJqiRd-FIqTnSc3CbQH4FYHE';
            'fatmagulcap090' = 'https://mega.nz/#!nIIEWajI!n5g0fdeGkMYBvXgQSPi9ffQU7Ii6Q5jSl1cJO_8ZiYE';
            'fatmagulcap091' = 'https://mega.nz/#!PFpXmZLR!THibuvkhS1iR7lDS2NtpKw4h4c9ZxqYun6v2Z8WrT2c';
            'fatmagulcap092' = 'https://mega.nz/#!rQYjTQBI!DBMYvN4DiS9Jc6UlZM19LfUwQpfYozoHoyd6KQKYmxI';
            'fatmagulcap093' = 'https://mega.nz/#!acoyHC7Q!RbNpNhATNj4dVZPK_eVpGR_Z7_cBzpcdUZIyD8kExio';
            'fatmagulcap094' = 'https://mega.nz/#!TMZEjLqC!rUKM3Fz75dkKN_AmngRr1ipfgrHIZziW32PhrZdkOtc';
            'fatmagulcap095' = 'https://mega.nz/#!fNw0jbaZ!-SMYgq_uaBcW4kjiR01rDnc5To-uVB-v5o5eVNjWc8A';
            'fatmagulcap096' = 'https://mega.nz/#!yZIRwT7A!bQcHd5rkgbb1YEayvbmrlPzE_QqxS_4xFOy1oGeBDiE';
            'fatmagulcap097' = 'https://mega.nz/#!KMJTED4S!FvYj_KkzyyedAQjwPOoLLtyXDqNVw9qmGvaVMqu0QuM';
            'fatmagulcap098' = 'https://mega.nz/#!zV4CkRBZ!fHu20rM_6XuvJyf2T2jpyXh13Ch_FGcRSFdjtdV81Lk';
            'fatmagulcap099' = 'https://mega.nz/#!XIRl0ZwR!_0YSMnUifVhGakEoBu_Cq-eWVvfR4i9RIFlGCJYoXBs';
            'fatmagulcap100' = 'https://mega.nz/#!3RoUXA4Y!y2KFmZIvaSUw8RdM07XimvpriM2QeGw4WmXTsOnIwgc';
            'fatmagulcap101' = 'https://mega.nz/#!iFxBhDLD!FhJZ__bPwsjGtde7nf4tQNNWBarQJVc8uoO5eMvGMa0';
            'fatmagulcap102' = 'https://mega.nz/#!WQxW2QoA!nHE6hoh0JcBpTBmcMw7FtTk9opE0-viHo_I73AdXMlo';
            'fatmagulcap103' = 'https://mega.nz/#!3VQyiLaR!LRt3YN9WGgurfKyfzWLJG1qSJ-Nm6EYmP1zwAC3YzEA';
            'fatmagulcap104' = 'https://mega.nz/#!zN4S2DxQ!Q-BAp-7WPA6qn53jp500b77WddhzYKaNQWKCtwFn8-w';
            'fatmagulcap105' = 'https://mega.nz/#!Hcx0hBrR!WC17R_D45xkdTUc5YcnasEeXuxK7u4oIFWP_agc2O1Y';
            'fatmagulcap106' = 'https://mega.nz/#!2MxnzYSZ!3nhrUG8rqvbrFOxq3uFoj5WuIUCCK_7cXdzxlz42w8w';
            'fatmagulcap107' = 'https://mega.nz/#!bJ40kaIK!KpUdPe-0o03U_NVDC-KER8AIYFovCZ082lavwjd6xlQ';
            'fatmagulcap108' = 'https://mega.nz/#!DZIBGYbY!-tQMeSdWOzwHLV7hxfwAHpqlnfofjrtYxRLQQ7tH2ls';
            'fatmagulcap109' = 'https://mega.nz/#!3NIVDYxb!Ye0AUIOR2lsF5fR9mF_yOVYgYAyO9rtTfX0gpxrPF24';
            'fatmagulcap110' = 'https://mega.nz/#!7M4GiJ5S!vQqrFSVOp3bm1_FeAJm2unn6nrHso4UvpJrcBDtAdlI';
            'fatmagulcap111' = 'https://mega.nz/#!zdohyJwA!GkHPvDufi9xh3I5YO5KjaVGwDRX0goTrriSCZxGcMYE';
            'fatmagulcap112' = 'https://mega.nz/#!vNBigTxD!CWX4-SPIEzSwsQkec6JKwdsgdY0Wu3GDJx0O7voNEr4';
            'fatmagulcap113' = 'https://mega.nz/#!7QxxgLTJ!j-FWxOYkgg787wzRNmr2jg5lWuxhCHN1iXU24iBqlf0';
            'fatmagulcap114' = 'https://mega.nz/#!WJ5wzQKS!d26LgsLkOVgyeZWG2E821aMJAjDuQugstPm9Jk9x2d0';
            'fatmagulcap115' = 'https://mega.nz/#!2MpAxJCJ!PMu3_cxiW277PPlXHzNMr9EaM2o_oL3CximsWrYc7mY';
            'fatmagulcap116' = 'https://mega.nz/#!DFZ12LJA!kub4K-LDrD61aL1hoPSZD39aP37DmlraEJ30bcP-fns';
            'fatmagulcap117' = 'https://mega.nz/#!TYhxUK6C!vbvrheCitTFXRDC8TWZ1vy4LqFY_8hY9nxwGFdJhqHk';
            'fatmagulcap118' = 'https://mega.nz/#!KFIGDKyL!uXSQn5CgiSf7xlmA3oaIUE5uDMRKowJ9J0UnOIqrWh4';
            'fatmagulcap119' = 'https://mega.nz/#!yBhhCAjZ!p8hqhn-371QXM_naUTzxZiGYBb634rk2oufXovyzqEc';
            'fatmagulcap120' = 'https://mega.nz/#!PVAWkbCa!IsalQOaDEVoy_aJO-FVZZk2UMnYfUJfsl2fTULZPUPY';
            'fatmagulcap121' = 'https://mega.nz/#!qFJGwJLJ!ofIo-ZbOtDmRS7gRbaJMCyaODstkRmZ_VzkabivTUKE';
            'fatmagulcap122' = 'https://mega.nz/#!ndwgVYIK!clo9O8rBsl1NK3OHAuCye35_VVpczT5B2lsiXJx5q8E';
            'fatmagulcap123' = 'https://mega.nz/#!qYJl3BrZ!IpFM68G9AabqST9eAWzj1j19ZlYt_Y0HA6cmpmHROPs';
            'fatmagulcap124' = 'https://mega.nz/#!WdIBHAKL!4ZT3fhw8P1FtI1v93WyXc0dIxyl8gkqcSlWUmuIHmYg';
            'fatmagulcap125' = 'https://mega.nz/#!XRx0XRwB!5pTdXszOpkJ-MXj4QGdkmIBof80YEabHHqBU7CshFg4';
            'fatmagulcap126' = 'https://mega.nz/#!PIpDURxQ!hGYwaeb-FQUvHin4Orcji4wiAPF_03V1uBa-Iyqz5pM';
            'fatmagulcap127' = 'https://mega.nz/#!2AomhKAB!lLtuZMPS36HZCq6IXIag9gB8dTtBAJjd6MGcjQyAkIo';
            'fatmagulcap128' = 'https://mega.nz/#!GQhXkDrY!ilPRnEc7jAq-0FqXEnlcShUSTmEwrwmc8my26oFRuvM';
            'fatmagulcap129' = 'https://mega.nz/#!rQwzlD5J!Hp1GPK4ogtJn41l7U8GsASfSsJ_59zq4apLfF7PZP34';
            'fatmagulcap130' = 'https://mega.nz/#!vMgCDAAa!LDo86PZmJki8MriWJ_otfyP24ozv5h33nIP60R6zIq4';
            'fatmagulcap131' = 'https://mega.nz/#!DIhhSIoR!i7TFy18hENqWN_B5NgYcJZRkAA6dkUcFLil1Afj95rA';
            'fatmagulcap132' = 'https://mega.nz/#!fYwhwBZY!MBokwdvt9frK2zxkrDrkZfMTjV5Pkakd6NEcfTpGgVo';
            'fatmagulcap133' = 'https://mega.nz/#!KFZTlK4S!VzwmxafmnbOeK4C1FmIk312L1qvSBB3COEMHaxkWVxI';
            'fatmagulcap134' = 'https://mega.nz/#!CcxjSTrZ!13LUIJXSq3rCkVoAhbkDZjWi19-aAsnkp5w6x0y4IfM';
            'fatmagulcap135' = 'https://mega.nz/#!eBAA1b7B!g886TxoroTzlm_FkIzoDp4WegmwYQ-ti3s5cTF3DT7g';
            'fatmagulcap136' = 'https://mega.nz/#!fFACmTra!scPpCouwwErlum_sfv7pTC9yXNMong0fL44ZHeWktzc';
            'fatmagulcap137' = 'https://mega.nz/#!O5khHbyT!zvDiP1m7u1rn2qIdibNKt0bbsdz3wO_YIRQaaEBg2x8';
            'fatmagulcap138' = 'https://mega.nz/#!eVRFUBoR!Nu02zIkGIgpQGjfpKMUZRkH_cNOmQ3F9lVziaE2TzSU';
            'fatmagulcap139' = 'https://mega.nz/#!3UB0xShQ!h4RKm4iKcIImKj1qLrEjAly9lOy-IlXo077cO5hiMa0';
            'fatmagulcap140' = 'https://mega.nz/#!eZIT2A7Z!76xiXRl56nHbqjDN_-aRExObM12BBZGo5eYg5CEwthM';
            'fatmagulcap141' = 'https://mega.nz/#!D9kgzDpA!pWPIaYTKamx48g-1HodsDI3kg5Xt94uY9_znK0DzSPk';
            'fatmagulcap142' = 'https://mega.nz/#!uh8ECYDJ!hOwIrCQvQGoshv1x_8AwmYow8xtyAHEBZlYqvj12ytI';
            'fatmagulcap143' = 'https://mega.nz/#!6p1xjJJA!vxbkUaNn-La3g880ic_Pgv2X-FATTPsfCUcvUYRi6Yw';
            'fatmagulcap144' = 'https://mega.nz/#!6llWXb4a!kLfBFUejaLsW39wIeIySqN-NFRciwMJIS638NNPBFQI';
            'fatmagulcap145' = 'https://mega.nz/#!CktlkLiC!DKV0NfCFVmpf3LoQkBD1GC4SzakCTBRRU1z9hUw-sZM';
            'fatmagulcap146' = 'https://mega.nz/#!OhNU1QBQ!YBOxOrhZxAFmxF3t5XKUCorGOaWxhHpqFkbw14AbkXA';
            'fatmagulcap147' = 'https://mega.nz/#!vlV1zJoQ!tmt-mDOtexnmMLRi8Jifd5RJhKfiw_QbMf-_dAf7hBQ';
            'fatmagulcap148' = 'https://mega.nz/#!LsNnxbxa!nkbsLgXCHx0DQvWza6DRHQKdWXAerwtqBAHJrcVipVM';
            'fatmagulcap149' = 'https://mega.nz/#!m0N2QYAZ!4duMiMD3WYpCijPYRxt9D1Ca1cBrdW0uzh3UkPIZ0V4';
            'fatmagulcap150' = 'https://mega.nz/#!X5VlHbpI!gFNv5axV-Ny9R8FtnBPxQtM83CUC9OafwUwYZZzEg5M';
            'fatmagulcap151' = 'https://mega.nz/#!rpFyjKyT!aip6ALXitG15oYtia2IQxbKjuUG_vbxN5UDOjRBqmHE';
            'fatmagulcap152' = 'https://mega.nz/#!yh9UyDQI!y28AzMqISJQG5NaI4qiqmX0ZNDKsFuVXgXP-AcXnXwM';
            'fatmagulcap153' = 'https://mega.nz/#!as013Bpa!B-BjXxDKoaEB51Ejc7kOHO3t2dDWGEAIcNb_QsGOloM';
            'fatmagulcap154' = 'https://mega.nz/#!qoUXXbJQ!UY6ASJ-sMA4y0lF_zCeCYw_xBysZyK_eVjryFnSFXnI';
            'fatmagulcap155' = 'https://mega.nz/#!agNxVSYA!wfW5LndDIf017QZuyWkTW0GJAE80R2I2SIz4dr25iT4';
            'fatmagulcap156' = 'https://mega.nz/#!2tUBjKaR!Hl1-q57JRUj4TtKyXGFCGALh6OCA6MNNY1B91PkengI';
            'fatmagulcap157' = 'https://mega.nz/#!L88lXDLb!IUSVn_6ZCr61Ci27BrXFZRNO_dInCcU5w0FuPpRHK84';
            'fatmagulcap158' = 'https://mega.nz/#!3x1HUIBA!8DhQz0xqvuNdIcNlb7EmQz5zXV3Yiek0iaYGKH4UO-8';
            'fatmagulcap159' = 'https://mega.nz/#!f00myLiL!UsCDnS6m_mTjQ7gJby_fzyOq4O7G9_naB0a0rq0XdjY';
            'fatmagulcap160' = 'https://mega.nz/#!2hNCVRCR!7yGqCZOLwqPDwAOtG9V5LccpdQaIEV9gCkee5arthMM';
            'fatmagulcap161' = 'https://mega.nz/#!e8MlRRQa!Ej0M0MnNeWrD8TskSQzvGs_4aYkVWcqL00XHZOqzup4';
            'fatmagulcap162' = 'https://mega.nz/#!q0ExnbLI!trgO14KUG3xq0_uhjxK-7YQTtvktrAzr-sbN0KuKRtM';
            'fatmagulcap163' = 'https://mega.nz/#!PpFmDCiQ!GZluA0Zv3ny92y_oqTsFQdn5hl1EjAOUTn7S7Is9-ZA';
            'fatmagulcap164' = 'https://mega.nz/#!u9VgGLDR!6l_WC2YNsQUSGMGO-un2igq_W1yVGTQW8s1llBNjKrM';
            'fatmagulcap165' = 'https://mega.nz/#!LotQXACQ!smsX1qIA3mDyJYhmDAC7PALEPokJIYq-Lh7MxCula4M';
            'fatmagulcap166' = 'https://mega.nz/#!q0dzVa7b!kgyOkO7VNbpIdbdiJm2Nfl-GdIHPF4_usMWJU0Drwuc';
            'fatmagulcap167' = 'https://mega.nz/#!Tx9Xma7B!dokdYdeZTDI2lvLToBj6ptzZRPl3RZXhv46YZVRPB54';
            'fatmagulcap168' = 'https://mega.nz/#!K1MWDIhK!KndzKXfoxF-EUBQxrpLPUVg2cD4WRJTZRNGWir3BUvA';
            'fatmagulcap169' = 'https://mega.nz/#!HhURiRiQ!2QsSHgIW8xJWomtkvNcHTp1DVDhxSvT06Y9EBdim6FA';
            'fatmagulcap170' = 'https://mega.nz/#!6sVmXSqY!3-j1NMrza0Abxj1C50KRXQ4vSwdz8X_vgttGvtUSR1g';
            'fatmagulcap171' = 'https://mega.nz/#!ms8nEQ4S!RLVZIhoyFpBoiflaMxn99LQaw5G-ZvQv8iMhfeDxVJo';
            'fatmagulcap172' = 'https://mega.nz/#!ut1wEZjR!xkB_8ajnrSvQbJevWNh-adMB4TgmRG6Icgfwl9FkzyY';
            'fatmagulcap173' = 'https://mega.nz/#!TgEhhDKa!pnIUjlKLjXRKWMRhWI6cRqwqnFDrl3GG-86B_13SrTI';
            'fatmagulcap174' = 'https://mega.nz/#!npUV2a4R!ezJhaQuQU1TZbpBmbvaZEUEokq-JizniXDyqnLkni6w';
            'fatmagulcap175' = 'https://mega.nz/#!P0ECzDLC!3IYh7nPJnly3uTQitAPeWiV6K84F5v1k4v_pdngzjag';
            'fatmagulcap176' = 'https://mega.nz/#!mg0QhBaR!yZ7150hX5wUeyYovIIWp2pXQqyv_D5ut2WGjQv9TKTU';
            'fatmagulcap177' = 'https://mega.nz/#!O5MizBAB!fK2S6cY-S0ktJvAExmonyIT3qOMC2miQlhTUW23aIdw';
            'fatmagulcap178' = 'https://mega.nz/#!z9diDT7J!HCaRWVClZcvKsXJuCHLky69B97gWL82qbZ-eubVG28g';
            'fatmagulcap179' = 'https://mega.nz/#!m1NTSBBY!Aw2YoweiRMH-1sxpII-i82Blrz1hi93ZXEw73NyeUO4';
            'fatmagulcap180' = 'https://mega.nz/#!300GRS5Y!nEUNcVE7lnDJFrKu-ihm9Yh36BbcH6tDQaIRidOkR3k';
            'fatmagulcap181' = 'https://mega.nz/#!XlsUnaiC!UsH768e7xyNPluA-eA3KKZs3IyyyM7bVVo58STjE8UA';
            'fatmagulcap182' = 'https://mega.nz/#!Gwc1xRJZ!q3obaYOeO-jwOaD8QGvDuKw7QeBIMwTn-pFKi35p6eQ';
            'fatmagulcap183' = 'https://mega.nz/#!3xc02YDQ!H6mMYGswimuxetzn6iw-K7iTeQAhwbVSFtUiDpD6CpQ';
            'fatmagulcap184' = 'https://mega.nz/#!bhNHHIpb!-ZpJVvhqP6eMRlK2KJcsLaSQ7vcojdciVpM1v93pcDE';
            'fatmagulcap185' = 'https://mega.nz/#!jlM3zYQA!sxYQNxt6XQxsL2PUSac7S4wYjiX4M9uRwgNthMxXWic';
            'fatmagulcap186' = 'https://mega.nz/#!j4VHkaSD!GWX-2yeGsCqIMCpGLUJxD28KXPCnVOKSUFwfAO7nfEs';
            'fatmagulcap187' = 'https://mega.nz/#!u01WQJAZ!EJ5wMA94hLEs79srnh50cOhsuSsipY1jC37cPX6MSS0';
            'fatmagulcap188' = 'https://mega.nz/#!L00nALjR!D4DbdYN1hIm8NUmWNiU5_0DYTFK32s3xetFgD7FK1oA';
            'fatmagulcap189' = 'https://mega.nz/#!Ox1EhRpb!A1XQSKAxbd8fkQ4gHZYN99EmCDRRFeUTSSyzPeVfVLQ';
            'fatmagulcap190' = 'https://mega.nz/#!jpcUFDiY!n3QqB4bK3nwsEGRvph4QWLllmS0ICv7FBFmlc_4m4EY';
            'fatmagulcap191' = 'https://mega.nz/#!D1kgkCDR!xDntpGnkMaeZ8Qi58eyyZGB2VQPsgjWXxQudHgZS4sw';
            'fatmagulcap192' = 'https://mega.nz/#!W8lnRAIL!FRySLIo7ZItFyQpihDUXrgdtA5LwOdI9yZTL9z775bI';
            'fatmagulcap193' = 'https://mega.nz/#!W1FXyB6D!WB5IDucE3jD4gUNrMpk3fGwp15RdQ-tSGLLMCaDHI0I';
            'fatmagulcap194' = 'https://mega.nz/#!Xl1EjJzb!VdDmvjYx3jEwtDwxbSv2u7b7GDmutEcZw878MU4jves';
            'fatmagulcap195' = 'https://mega.nz/#!CpUiybYJ!Z-TvHVgNpy8LH1FSXkteMx9HDgjiWkOgXToK6CnnAJc';
            'fatmagulcap196' = 'https://mega.nz/#!mlUE0QJJ!RKV9tSCYF_3JbkhNJrWJ7paP0r7s2RpuKtg-Y37uJWg';
            'fatmagulcap197' = 'https://mega.nz/#!vs11iSyb!C9IPoFm96xjrNtVKI3B4uvnlfLSUqhWQEki3f8oNtyU';
            'fatmagulcap198' = 'https://mega.nz/#!rg0i3QTB!yuyv7M7pK6AoridOSVqPbqjDGzJkBhSYLQB84Ic9qhw';
            'fatmagulcap199' = 'https://mega.nz/#!XtsmwRpB!LWvVVeujYVJyBxSvzFMAeK0Yl5Z2divuP_kdm1SfBHs';
            'fatmagulcap200' = 'https://mega.nz/#!XwkSRZbS!zQXnBg_U6UWFZkWbjNyL4FZrvNyYBbarx64o3O6pJkE';
            'fatmagulcap201' = 'https://mega.nz/#!34MA0bBL!SMNLKNBDtFMyHRx7Ii5tYVu7vhxTgDLlrH25Vza8G78';
            'fatmagulcap202' = 'https://mega.nz/#!Ph0wWTxS!OTDfDeSvrt4U13KkiZsxTOgyOpozdsZz-JwiDRhPX8Q';
            'fatmagulcap203' = 'https://mega.nz/#!q1kgHAJZ!pWXJICrnPUsj9cvHkZAO31F3FWohF_Qa99UnYohArig';
            'fatmagulcap204' = 'https://mega.nz/#!mx1XGJiQ!rihcEl7kExXa2uIxz23nNDH-v6HnYywr11fpafB2mJ0';
            'fatmagulcap205' = 'https://mega.nz/#!ywc3iaQb!UeRKfPojAtJzDmKJqmVYrlACqxutOEt-t0Z9ZNfM0-4';
            'fatmagulcap206' = 'https://mega.nz/#!Ghln0aJL!HPYaCikXbGIv3fU3Uu2YKErn0KfYPjlL05018021au0';
            'fatmagulcap207' = 'https://mega.nz/#!Ok1DSSjC!HZZ_O4hIT0L2RYamui74Wa5ZqwZWTB7Vh234Bxu4xtM';
            'fatmagulcap208' = 'https://mega.nz/#!OpUljYBJ!9btT3UXJM9-rB0Z09lIrNZ3Enra-VaANPqtj8Xee8jk'
        }
    } else {
        [hashtable]$mega_urls = @{}

        $www = Invoke-WebRequest 'http://fatmagulnovelaturca.blogspot.com/' -UseBasicParsing
        foreach ($adfly_link in ($www.Links | ?{ $_.innerText -ilike '*adf.ly*fatmagul*' }) {
            if ((Invoke-WebRequest $adfly_link.href -UseBasicParsing).Content -match '"(https:\/\/mega\.nz\/\#\![^"]+)"') {
                $chapter = $adfly_link.href.Split('/')[-1]
                $mega_url = $Matches[1]
                Write-Verbose "Found: ${chapter}: ${mega_url}"
                $mega_urls.Add($chapter, $mega_url)
            }
        }
    }

    Write-Output $mega_urls
}

$mega_urls = Get-MegaUrls

# Rename everything back to original so we don't re-download.
foreach ($item in (Get-ChildItem $DownloadTo)) { 
    $item.Name -match '\s(\d+)\.(.+)' | Out-Null
    Rename-Item $item.FullName ($item.Name.Replace('.e', ' ')) -ErrorAction Ignore
}


# Download everything, and fix names.
$jobs = @{}

foreach ($url in $mega_urls) {
    while ((Get-Job -State 'Running' | Measure-Object).Count -gt 5) {
        Start-Sleep -Seconds 10
    }

    $job = Start-Job -ArgumentList @($MegaDL, $DownloadTo, $url) -ScriptBlock {
        & $args[0] $args[2] --path $args[1]
    }

    Write-Verbose "Downloading: $($job.Id): ${url}"
    $jobs.Add($url, $job.Id) | Out-Null
    [System.Collections.ArrayList]$jobs_remove = @()

    foreach ($j in $jobs.GetEnumerator()) {
        if ((Get-Job -Id $j.Value).State -eq 'Completed') {
            try {
                (Receive-Job -Id $j.Value -ErrorAction Stop) -match 'Fatmagul\s(\d+)\.([^:]+)' | Out-Null
            } catch {
                $Error[0].Exception.Message -match 'Fatmagul\s(\d+)\.([^\s]+)' | Out-Null
            } finally {
                Rename-Item "${path}\$($Matches[0])" ("Fatmagul.e{0:d3}.{1}" -f ([int]$Matches[1], $Matches[2])) -ErrorAction Ignore
            }

            # Can't remove Keys from the object we're looping through.
            # So ... we'll do it later.
            $jobs_remove.Add($j.Name) | Out-Null
            break
        }
    }

    foreach ($j in $jobs_remove) {
        $jobs.Remove($j) | Out-Null
    }
}