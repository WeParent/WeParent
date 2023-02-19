import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weparent/features/settings/profile.dart';
import 'package:weparent/view_model/userViewModel.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsPage2State();
}

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;

  const CustomListTile({
    required this.title,
    required this.icon,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class _SettingsPage2State extends State<Settings> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDark ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView(
              children: [
                _SingleSection(
                  title: "General",
                  children: [
                    CustomListTile(
                      title: "Dark Mode",
                      icon: Icons.dark_mode_outlined,
                      trailing: Switch(
                        value: _isDark,
                        onChanged: (value) {
                          setState(() {
                            _isDark = value;
                          });
                        },
                      ),
                    ),
                    const CustomListTile(
                      title: "Notifications",
                      icon: Icons.notifications_none_rounded,
                      onTap: null,
                    ),
                    const CustomListTile(
                      title: "Security Status",
                      icon: CupertinoIcons.lock_shield,
                      onTap: null,
                    ),
                  ],
                ),
                const Divider(),
                _SingleSection(
                  title: "Organization",
                  children: [
                    CustomListTile(
                      title: "Profile",
                      icon: Icons.person_outline_rounded,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              userProfileViewModel: UserProfileViewModel(
                                  accessToken:
                                      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Il9pZCI6IjYzZWUyZjYxZjQ1YTgyZmM3ZGVlNWVhMyIsIkZpcnN0TmFtZSI6IkFsYSIsIkxhc3ROYW1lIjoiQmVuIFJlamFiIiwiRW1haWwiOiJhbGFlZGRpbmUuYmVucmVqYWJAZXNwcml0LnRuIiwiUGFzc3dvcmQiOiIkMmEkMTAkbkZVM2wzRDlUM0tyZ3F1UUhBblpMZUNBbEltc2kwTHNUWjZNMHBSUW9jbmd3V0xMZVpkcXkiLCJQcm9maWxlUGhvdG8iOiJodHRwOi8vbG9jYWxob3N0OjkwOTAvbWVkaWEvZGVmYXVsdC5wbmciLCJjcmVhdGVkQXQiOiIyMDIzLTAyLTE2VDEzOjI4OjAxLjU2NFoiLCJ1cGRhdGVkQXQiOiIyMDIzLTAyLTE4VDEwOjM4OjIxLjk2NVoiLCJfX3YiOjAsIlRva2VuIjoiZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SjFjMlZ5SWpwN0lsOXBaQ0k2SWpZelpXVXlaall4WmpRMVlUZ3labU0zWkdWbE5XVmhNeUlzSWtacGNuTjBUbUZ0WlNJNklrRnNZU0lzSWt4aGMzUk9ZVzFsSWpvaVFtVnVJRkpsYW1GaUlpd2lSVzFoYVd3aU9pSmhiR0ZsWkdScGJtVXVZbVZ1Y21WcVlXSkFaWE53Y21sMExuUnVJaXdpVUdGemMzZHZjbVFpT2lJa01tRWtNVEFrYmtaVk0yd3pSRGxVTTB0eVozRjFVVWhCYmxwTVpVTkJiRWx0YzJrd1RITlVXalpOTUhCU1VXOWpibWQzVjB4TVpWcGtjWGtpTENKUWNtOW1hV3hsVUdodmRHOGlPaUpvZEhSd09pOHZiRzlqWVd4b2IzTjBPamt3T1RBdmJXVmthV0V2WkdWbVlYVnNkQzV3Ym1jaUxDSmpjbVZoZEdWa1FYUWlPaUl5TURJekxUQXlMVEUyVkRFek9qSTRPakF4TGpVMk5Gb2lMQ0oxY0dSaGRHVmtRWFFpT2lJeU1ESXpMVEF5TFRFM1ZESXhPalV5T2pNNUxqRTFORm9pTENKZlgzWWlPakFzSWxSdmEyVnVJam9pWlhsS2FHSkhZMmxQYVVwSlZYcEpNVTVwU1hOSmJsSTFZME5KTmtscmNGaFdRMG81TG1WNVNqRmpNbFo1U1dwd04wbHNPWEJhUTBrMlNXcFplbHBYVlhsYWFsbDRXbXBSTVZsVVozbGFiVTB6V2tkV2JFNVhWbWhOZVVselNXdGFjR051VGpCVWJVWjBXbE5KTmtsclJuTlpVMGx6U1d0NGFHTXpVazlaVnpGc1NXcHZhVkZ0Vm5WSlJrcHNZVzFHYVVscGQybFNWekZvWVZkM2FVOXBTbWhpUjBac1drZFNjR0p0VlhWWmJWWjFZMjFXY1ZsWFNrRmFXRTUzWTIxc01FeHVVblZKYVhkcFZVZEdlbU16WkhaamJWRnBUMmxKYTAxdFJXdE5WRUZyWW10YVZrMHlkM3BTUkd4VlRUQjBlVm96UmpGVlZXaENZbXh3VFZwVlRrSmlSV3gwWXpKcmQxUklUbFZYYWxwT1RVaENVMVZYT1dwaWJXUXpWakI0VFZwV2NHdGpXR3RwVEVOS1VXTnRPVzFoVjNoc1ZVZG9kbVJIT0dsUGFVcHZaRWhTZDA5cE9IWmlSemxxV1ZkNGIySXpUakJQYW10M1QxUkJkbUpYVm10aFYwVjJXa2RXYlZsWVZuTmtRelYzWW0xamFVeERTbXBqYlZab1pFZFdhMUZZVVdsUGFVbDVUVVJKZWt4VVFYbE1WRVV5VmtSRmVrOXFTVFJQYWtGNFRHcFZNazVHYjJsTVEwb3hZMGRTYUdSSFZtdFJXRkZwVDJsSmVVMUVTWHBNVkVGNVRGUkZNMVpFUVRWUGFra3hUMnBCZDB4cVRYaE5NVzlwVEVOS1psZ3pXV2xQYWtGelNXeFNkbUV5Vm5WSmFtOXBXbGhzUzJGSFNraFpNbXhRWVZWd1NsWlljRXBOVlRWd1UxaE9TbUpzU1RGWk1FNUtUbXRzY21OR2FGZFJNRzgxVEcxV05WTnFSbXBOYkZvMVUxZHdkMDR3YkhOUFdFSmhVVEJyTWxOWGNGcGxiSEJZVmxoc1lXRnNiRFJYYlhCU1RWWnNWVm96YkdGaVZUQjZWMnRrVjJKRk5WaFdiV2hPWlZWc2VsTlhkR0ZqUjA1MVZHcENWV0pWV2pCWGJFNUtUbXRzY2xKdVRscFZNR3g2VTFkME5HRkhUWHBWYXpsYVZucEdjMU5YY0haaFZrWjBWbTVXU2xKcmNITlpWekZIWVZWc2NHUXliRk5XZWtadldWWmtNMkZWT1hCVGJXaHBVakJhYzFkclpGTmpSMHAwVmxoV1dtSldXakZaTWpGWFkxWnNXRk5yUm1GWFJUVXpXVEl4YzAxRmVIVlZibFpLWVZoa2NGWlZaRWRsYlUxNldraGFhbUpXUm5CVU1teEtZVEF4ZEZKWGRFNVdSVVp5V1cxMFlWWnJNSGxrTTNCVFVrZDRWbFJVUWpCbFZtOTZVbXBHVmxaWGFFTlpiWGgzVkZad1ZsUnJTbWxTVjNnd1dYcEtjbVF4VWtsVWJGWllZV3h3VDFSVmFFTlZNVlpZVDFkd2FXSlhVWHBXYWtJMFZGWndWMk5IZEdwWFIzUndWRVZPUzFWWFRuUlBWekZvVmpOb2MxWlZaRzlrYlZKSVQwZHNVR0ZWY0haYVJXaFRaREE1Y0U5SVdtbFNlbXh4VjFaa05HSXlTWHBVYWtKUVlXMTBNMVF4VWtKa2JVcFlWbTEwYUZZd1ZqSlhhMlJYWWxac1dWWnVUbXRSZWxZeldXMHhhbUZWZUVSVGJYQnFZbFphYjFwRlpGZGhNVVpaVlZkc1VHRlZiRFZVVlZKS1pXdDRWVkZZYkUxV1JWVjVWbXRTUm1Wck9YRlRWRkpRWVd0R05GUkhjRlpOYXpWSFlqSnNUVkV3YjNoWk1HUlRZVWRTU0ZadGRGSlhSa1p3VkRKc1NtVlZNVVZUV0hCTlZrVkdOVlJHVWtaTmJGcEZVbFJHVUdGck1IcFVNbkJLVFZWNGNXRXpjRTVXYlRsd1ZFVk9TMXBzWjNwWFYyeFFZV3RHZWxOWGVGTmtiVVY1Vm01V1NtRnRPWEJYYkdoelV6SkdTRk5yYUZwTmJYaFJXVlpXZDFOc1dsbGpSWEJPVmxSV2QxVXhhRTlUYlVwelUxUkdXazFGTlV0VWJYUnpZMjFPUjJGR1pGSk5Semd4VkVjeFYwNVdUbkZTYlhCT1lrWnZNVlV4Wkhka01EUjNZa2hPVUZkRlNtaFZWRUp5VFd4T1dHTkdjR3hpU0VKWlZteG9jMWxYUm5OaVJGSllZbGhDVTFSV1duTldWbTk2WWtkR2FWWlVRalpXTW5SclZqSktSazVXYUZkaVYyaFBXbFpXYzJWc1RsaGtSMFpxVWpBMU1WWkhjRU5XVjBwV1YycENXR0pGTlV0VWJYUnpZMnhLZFZSc2NGWk5SWEJJVmpKMGExVXlUa2hUYmxKWFZqSjRUbFZVUW5kVWJHUlhZVVU1VGxKc1NqQlZiVFZUV1ZaVmQyRjZTbFJXTTFKTVdXdGtTMk5HUm5OVWJVWlhUVEJLZGxZeFpITlRiVTEzWWtoS1YySnNTbUZXYWtvMFpXeE9XR05JV21oV2JYaFpXbFZrYjFsV1dYaFRia3BhVm0xTmVGbHJWalJrUms1MFpVZHNhV0V6UW5wWFZtTjRVakpHVjFKcmFGZGlia0p4VlRCV2QyUXhjRVpVVkVaT1VqQndkMVV4YUU5VGJVcEdVMjA1V21Wck5WQlVWRXBLWld4T2RHUkZjR2hpVkd4M1ZUSjBVMU15UmtaalJWWlRWMGRTVEZWdWNGZFRSbHB6VldzNWFrMUVRak5XVmxKWFZqRktSazVWTVZwTmFrWnlXbFZrVTFZeFNuSmlSa3BYWld4YWIxWnJWbXRXTVVwSFVteG9iRkpZUW5CV01GVXhaREZTVmxacVVteGlSbkJJV1c1d1MxWldXa1pUYWs1WFZqTm9TRnBIZUhKbFZUVllUbGQwVGxZeFNrOVdhMVpyVmpGc1YyTkZiRk5oYkZwTFdWWm9hMk5HV2xaaFJYUnJZa2hDTUZscmFFOVpWbHB5VTI1YVdtRnJOVlJhUjNSelkxZEplV0pIYUZSU2Eyd3pWMVJDVTJSdFVuSmtNMnhzVTBad1lWUlhkR0ZsYkd4V1dYcFdiR0pXU2taWmJuQlhWR3hLU0dSRVRsVlNSV3cwV1d0YWQxTkhTa2hoUlRGT1lrVndlbFl5TUhoU01ERllVMnRzVmxkR1duRlZibkJYWkZaT1dHSkVUbWhXYlhRMlZUSXhORmRzWkVkVGJrNVlZVEZhU0ZSVlZuTmpWMGw1WWtVMWFHRXdXVEZXUm1oeVpESlJkMDFZUWs1VFIyaFFXV3RhUjA1R1VsbGpTRnBzVmxSc1JsbHFUbXRVYkZZMlZWaG9WV0pZUWxSWFZsWnpZMGRSZVdKSGRGaFNWWEI1VmpGYWIxVXlTa2RqUlZwVFlXdEtTMWxYTURWalJsSllZMFZLYkZaVVJURlVWV2hyVkcxR1ZWRnFVbFZpV0doVFdsVlZNVlpYU1hwYVJUVlhVbnByTUZaR1ZrNU5SVFZHVDFWV2FWSXdXa3RaVm1oclkwWmtSVkpVVms1aE1uaDRXV3BPYTFSV1JYZGpSbHBhWVd0dmQxbHJaRXRqUms1VlYydHdhVlpzYTNoV1ZFbDRZakpHVjFOWWJGVmlhMHBXVkZjeE5GUkdWWGhYYkdSUFlrVTFWbFZ0Y3pWaFJscFlaVVJhVmsxWFRYaFdWRUV4VjBaU2NsVnNVbGRTYmtKTVYxWlNUMUV4WkZkWGJrcFZZVE5TVVZaWWNGZGpNWEJYVm01a2EwMVhVbmxXUjNSM1ZESkZlV1ZJYUZkTlYyZ3pWMVphV21WR1duRldiR2hwVjBWS2FGZHNWbUZrTWs1WFZteFdVMkpJUWxoVmFrcFNUVlpaZVUxSWFGVmhla0kwV1RCV2IxWXlTbGxoUmtKWFlXdGFhRmxxUmxOWFYwcEdZMGR3VGxJelozZFhWM1JyWWpKRmVGSllaR2hsYTNCV1ZtMTRTMWxXVWxWUlZFWnFWbXh3VmxWdGVFTldNVXAwWkVSYVYxSnNXbEJVVkVwSFZqSk9SMkpIYUZSU01VcE1WMVpqZDA1Vk5VZFZibEpxVWpOQ1QxbFljRmRXYkdSWlkwVk9WV0pGY0VsV1IzQlBXVmRLUmxacVJtRlNSVnB4V2xaYVUwNXNXblJsUjBaWFltdEtNbGRVU25Ka01ERklWVmhrVUZaR1NsVlpWekZ2VGxad1IxVnVUbXROVjFKNVdsVm9hMVZ0U2xkalJUVmFWMGhDYUZwRVFYaGpiR1JaWWtaS1dGTkZTak5XVkVKclRUQTFWMVJ1Um1GVFNFSlZWbFJDZGs1V1VrWlVhM1JxVW0xNFdsWldaSE5WUjBaeVZsaHNWV0p1UW1GVVZsVXhZMVpLVlZSc1FsZFNWRVkyVlRGamVGWXdOVWhVYTFKVVZrWndUMVpyV25KbGJGSjBZMFphVGsxRVZuaFZiRkpYVkdzeE5sRllWazFYUlZwdFZrYzFTMlJzVmtaaVJUVnFUVWRTVjFreGFHRk5Wa3AxVm01U2JGSldTbEpYUkVKTFZsWmFXVmR0T1U1TlZVcFJXa1ZWTVZKR1NsaFhhM1JvVFZWd1IxVnJhR0ZWUjA0MVUycHNUVkV3Y0hkWFZtaFNZVlU1Y1ZKVVNrOWxiR3Q1VkZkd1ZrNVZNVVZSV0U1S1lsWlpNRmt3VGtwT2F6RlZWMVJPVDJGc2EzZFVWVkpPWkRBeFNVMUROVTlUTTBwQ1RteEtNbEZxVGxoV01XUkdXVlZzY0U5RlZqSmFiWEJZVDFWR05scHJjRWxaTTFaNVkzcHNlazFVVWxsV1NGSlRUMWhHV2tsdU1ITkpiV3hvWkVOSk5rMVVXVE5PYWxrelRVUmpNVTlUZDJsYVdHaDNTV3B2ZUU1cVl6Sk9hbWN4VFZSVk5XWlJMbXgyVW5oNkxVZDBjRWd4VG0xclZHOXJZMFpLT0dOMlQwWkNiRXhNZEVZME1HMUhWVXhTZVhsaUxXc2lmU3dpYVdGMElqb3hOamMyTnpFMk56QXhMQ0psZUhBaU9qRTJOelkzTXpFeE1ERjkub21hc0J3dEgyVnU4ckh4d0FJNFkzaEFILS1ISFF0UzlKSWNCNkRVODBtdyJ9LCJpYXQiOjE2NzY3MzEzMTIsImV4cCI6MTY3Njc0NTcxMn0.PIPRVka9__4Eq_9L4LxGkBEN95tusZwFrknkkcv0G4w'),
                              accessToken:
                                  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Il9pZCI6IjYzZWUyZjYxZjQ1YTgyZmM3ZGVlNWVhMyIsIkZpcnN0TmFtZSI6IkFsYSIsIkxhc3ROYW1lIjoiQmVuIFJlamFiIiwiRW1haWwiOiJhbGFlZGRpbmUuYmVucmVqYWJAZXNwcml0LnRuIiwiUGFzc3dvcmQiOiIkMmEkMTAkbkZVM2wzRDlUM0tyZ3F1UUhBblpMZUNBbEltc2kwTHNUWjZNMHBSUW9jbmd3V0xMZVpkcXkiLCJQcm9maWxlUGhvdG8iOiJodHRwOi8vbG9jYWxob3N0OjkwOTAvbWVkaWEvZGVmYXVsdC5wbmciLCJjcmVhdGVkQXQiOiIyMDIzLTAyLTE2VDEzOjI4OjAxLjU2NFoiLCJ1cGRhdGVkQXQiOiIyMDIzLTAyLTE4VDEwOjM4OjIxLjk2NVoiLCJfX3YiOjAsIlRva2VuIjoiZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SjFjMlZ5SWpwN0lsOXBaQ0k2SWpZelpXVXlaall4WmpRMVlUZ3labU0zWkdWbE5XVmhNeUlzSWtacGNuTjBUbUZ0WlNJNklrRnNZU0lzSWt4aGMzUk9ZVzFsSWpvaVFtVnVJRkpsYW1GaUlpd2lSVzFoYVd3aU9pSmhiR0ZsWkdScGJtVXVZbVZ1Y21WcVlXSkFaWE53Y21sMExuUnVJaXdpVUdGemMzZHZjbVFpT2lJa01tRWtNVEFrYmtaVk0yd3pSRGxVTTB0eVozRjFVVWhCYmxwTVpVTkJiRWx0YzJrd1RITlVXalpOTUhCU1VXOWpibWQzVjB4TVpWcGtjWGtpTENKUWNtOW1hV3hsVUdodmRHOGlPaUpvZEhSd09pOHZiRzlqWVd4b2IzTjBPamt3T1RBdmJXVmthV0V2WkdWbVlYVnNkQzV3Ym1jaUxDSmpjbVZoZEdWa1FYUWlPaUl5TURJekxUQXlMVEUyVkRFek9qSTRPakF4TGpVMk5Gb2lMQ0oxY0dSaGRHVmtRWFFpT2lJeU1ESXpMVEF5TFRFM1ZESXhPalV5T2pNNUxqRTFORm9pTENKZlgzWWlPakFzSWxSdmEyVnVJam9pWlhsS2FHSkhZMmxQYVVwSlZYcEpNVTVwU1hOSmJsSTFZME5KTmtscmNGaFdRMG81TG1WNVNqRmpNbFo1U1dwd04wbHNPWEJhUTBrMlNXcFplbHBYVlhsYWFsbDRXbXBSTVZsVVozbGFiVTB6V2tkV2JFNVhWbWhOZVVselNXdGFjR051VGpCVWJVWjBXbE5KTmtsclJuTlpVMGx6U1d0NGFHTXpVazlaVnpGc1NXcHZhVkZ0Vm5WSlJrcHNZVzFHYVVscGQybFNWekZvWVZkM2FVOXBTbWhpUjBac1drZFNjR0p0VlhWWmJWWjFZMjFXY1ZsWFNrRmFXRTUzWTIxc01FeHVVblZKYVhkcFZVZEdlbU16WkhaamJWRnBUMmxKYTAxdFJXdE5WRUZyWW10YVZrMHlkM3BTUkd4VlRUQjBlVm96UmpGVlZXaENZbXh3VFZwVlRrSmlSV3gwWXpKcmQxUklUbFZYYWxwT1RVaENVMVZYT1dwaWJXUXpWakI0VFZwV2NHdGpXR3RwVEVOS1VXTnRPVzFoVjNoc1ZVZG9kbVJIT0dsUGFVcHZaRWhTZDA5cE9IWmlSemxxV1ZkNGIySXpUakJQYW10M1QxUkJkbUpYVm10aFYwVjJXa2RXYlZsWVZuTmtRelYzWW0xamFVeERTbXBqYlZab1pFZFdhMUZZVVdsUGFVbDVUVVJKZWt4VVFYbE1WRVV5VmtSRmVrOXFTVFJQYWtGNFRHcFZNazVHYjJsTVEwb3hZMGRTYUdSSFZtdFJXRkZwVDJsSmVVMUVTWHBNVkVGNVRGUkZNMVpFUVRWUGFra3hUMnBCZDB4cVRYaE5NVzlwVEVOS1psZ3pXV2xQYWtGelNXeFNkbUV5Vm5WSmFtOXBXbGhzUzJGSFNraFpNbXhRWVZWd1NsWlljRXBOVlRWd1UxaE9TbUpzU1RGWk1FNUtUbXRzY21OR2FGZFJNRzgxVEcxV05WTnFSbXBOYkZvMVUxZHdkMDR3YkhOUFdFSmhVVEJyTWxOWGNGcGxiSEJZVmxoc1lXRnNiRFJYYlhCU1RWWnNWVm96YkdGaVZUQjZWMnRrVjJKRk5WaFdiV2hPWlZWc2VsTlhkR0ZqUjA1MVZHcENWV0pWV2pCWGJFNUtUbXRzY2xKdVRscFZNR3g2VTFkME5HRkhUWHBWYXpsYVZucEdjMU5YY0haaFZrWjBWbTVXU2xKcmNITlpWekZIWVZWc2NHUXliRk5XZWtadldWWmtNMkZWT1hCVGJXaHBVakJhYzFkclpGTmpSMHAwVmxoV1dtSldXakZaTWpGWFkxWnNXRk5yUm1GWFJUVXpXVEl4YzAxRmVIVlZibFpLWVZoa2NGWlZaRWRsYlUxNldraGFhbUpXUm5CVU1teEtZVEF4ZEZKWGRFNVdSVVp5V1cxMFlWWnJNSGxrTTNCVFVrZDRWbFJVUWpCbFZtOTZVbXBHVmxaWGFFTlpiWGgzVkZad1ZsUnJTbWxTVjNnd1dYcEtjbVF4VWtsVWJGWllZV3h3VDFSVmFFTlZNVlpZVDFkd2FXSlhVWHBXYWtJMFZGWndWMk5IZEdwWFIzUndWRVZPUzFWWFRuUlBWekZvVmpOb2MxWlZaRzlrYlZKSVQwZHNVR0ZWY0haYVJXaFRaREE1Y0U5SVdtbFNlbXh4VjFaa05HSXlTWHBVYWtKUVlXMTBNMVF4VWtKa2JVcFlWbTEwYUZZd1ZqSlhhMlJYWWxac1dWWnVUbXRSZWxZeldXMHhhbUZWZUVSVGJYQnFZbFphYjFwRlpGZGhNVVpaVlZkc1VHRlZiRFZVVlZKS1pXdDRWVkZZYkUxV1JWVjVWbXRTUm1Wck9YRlRWRkpRWVd0R05GUkhjRlpOYXpWSFlqSnNUVkV3YjNoWk1HUlRZVWRTU0ZadGRGSlhSa1p3VkRKc1NtVlZNVVZUV0hCTlZrVkdOVlJHVWtaTmJGcEZVbFJHVUdGck1IcFVNbkJLVFZWNGNXRXpjRTVXYlRsd1ZFVk9TMXBzWjNwWFYyeFFZV3RHZWxOWGVGTmtiVVY1Vm01V1NtRnRPWEJYYkdoelV6SkdTRk5yYUZwTmJYaFJXVlpXZDFOc1dsbGpSWEJPVmxSV2QxVXhhRTlUYlVwelUxUkdXazFGTlV0VWJYUnpZMjFPUjJGR1pGSk5Semd4VkVjeFYwNVdUbkZTYlhCT1lrWnZNVlV4Wkhka01EUjNZa2hPVUZkRlNtaFZWRUp5VFd4T1dHTkdjR3hpU0VKWlZteG9jMWxYUm5OaVJGSllZbGhDVTFSV1duTldWbTk2WWtkR2FWWlVRalpXTW5SclZqSktSazVXYUZkaVYyaFBXbFpXYzJWc1RsaGtSMFpxVWpBMU1WWkhjRU5XVjBwV1YycENXR0pGTlV0VWJYUnpZMnhLZFZSc2NGWk5SWEJJVmpKMGExVXlUa2hUYmxKWFZqSjRUbFZVUW5kVWJHUlhZVVU1VGxKc1NqQlZiVFZUV1ZaVmQyRjZTbFJXTTFKTVdXdGtTMk5HUm5OVWJVWlhUVEJLZGxZeFpITlRiVTEzWWtoS1YySnNTbUZXYWtvMFpXeE9XR05JV21oV2JYaFpXbFZrYjFsV1dYaFRia3BhVm0xTmVGbHJWalJrUms1MFpVZHNhV0V6UW5wWFZtTjRVakpHVjFKcmFGZGlia0p4VlRCV2QyUXhjRVpVVkVaT1VqQndkMVV4YUU5VGJVcEdVMjA1V21Wck5WQlVWRXBLWld4T2RHUkZjR2hpVkd4M1ZUSjBVMU15UmtaalJWWlRWMGRTVEZWdWNGZFRSbHB6VldzNWFrMUVRak5XVmxKWFZqRktSazVWTVZwTmFrWnlXbFZrVTFZeFNuSmlSa3BYWld4YWIxWnJWbXRXTVVwSFVteG9iRkpZUW5CV01GVXhaREZTVmxacVVteGlSbkJJV1c1d1MxWldXa1pUYWs1WFZqTm9TRnBIZUhKbFZUVllUbGQwVGxZeFNrOVdhMVpyVmpGc1YyTkZiRk5oYkZwTFdWWm9hMk5HV2xaaFJYUnJZa2hDTUZscmFFOVpWbHB5VTI1YVdtRnJOVlJhUjNSelkxZEplV0pIYUZSU2Eyd3pWMVJDVTJSdFVuSmtNMnhzVTBad1lWUlhkR0ZsYkd4V1dYcFdiR0pXU2taWmJuQlhWR3hLU0dSRVRsVlNSV3cwV1d0YWQxTkhTa2hoUlRGT1lrVndlbFl5TUhoU01ERllVMnRzVmxkR1duRlZibkJYWkZaT1dHSkVUbWhXYlhRMlZUSXhORmRzWkVkVGJrNVlZVEZhU0ZSVlZuTmpWMGw1WWtVMWFHRXdXVEZXUm1oeVpESlJkMDFZUWs1VFIyaFFXV3RhUjA1R1VsbGpTRnBzVmxSc1JsbHFUbXRVYkZZMlZWaG9WV0pZUWxSWFZsWnpZMGRSZVdKSGRGaFNWWEI1VmpGYWIxVXlTa2RqUlZwVFlXdEtTMWxYTURWalJsSllZMFZLYkZaVVJURlVWV2hyVkcxR1ZWRnFVbFZpV0doVFdsVlZNVlpYU1hwYVJUVlhVbnByTUZaR1ZrNU5SVFZHVDFWV2FWSXdXa3RaVm1oclkwWmtSVkpVVms1aE1uaDRXV3BPYTFSV1JYZGpSbHBhWVd0dmQxbHJaRXRqUms1VlYydHdhVlpzYTNoV1ZFbDRZakpHVjFOWWJGVmlhMHBXVkZjeE5GUkdWWGhYYkdSUFlrVTFWbFZ0Y3pWaFJscFlaVVJhVmsxWFRYaFdWRUV4VjBaU2NsVnNVbGRTYmtKTVYxWlNUMUV4WkZkWGJrcFZZVE5TVVZaWWNGZGpNWEJYVm01a2EwMVhVbmxXUjNSM1ZESkZlV1ZJYUZkTlYyZ3pWMVphV21WR1duRldiR2hwVjBWS2FGZHNWbUZrTWs1WFZteFdVMkpJUWxoVmFrcFNUVlpaZVUxSWFGVmhla0kwV1RCV2IxWXlTbGxoUmtKWFlXdGFhRmxxUmxOWFYwcEdZMGR3VGxJelozZFhWM1JyWWpKRmVGSllaR2hsYTNCV1ZtMTRTMWxXVWxWUlZFWnFWbXh3VmxWdGVFTldNVXAwWkVSYVYxSnNXbEJVVkVwSFZqSk9SMkpIYUZSU01VcE1WMVpqZDA1Vk5VZFZibEpxVWpOQ1QxbFljRmRXYkdSWlkwVk9WV0pGY0VsV1IzQlBXVmRLUmxacVJtRlNSVnB4V2xaYVUwNXNXblJsUjBaWFltdEtNbGRVU25Ka01ERklWVmhrVUZaR1NsVlpWekZ2VGxad1IxVnVUbXROVjFKNVdsVm9hMVZ0U2xkalJUVmFWMGhDYUZwRVFYaGpiR1JaWWtaS1dGTkZTak5XVkVKclRUQTFWMVJ1Um1GVFNFSlZWbFJDZGs1V1VrWlVhM1JxVW0xNFdsWldaSE5WUjBaeVZsaHNWV0p1UW1GVVZsVXhZMVpLVlZSc1FsZFNWRVkyVlRGamVGWXdOVWhVYTFKVVZrWndUMVpyV25KbGJGSjBZMFphVGsxRVZuaFZiRkpYVkdzeE5sRllWazFYUlZwdFZrYzFTMlJzVmtaaVJUVnFUVWRTVjFreGFHRk5Wa3AxVm01U2JGSldTbEpYUkVKTFZsWmFXVmR0T1U1TlZVcFJXa1ZWTVZKR1NsaFhhM1JvVFZWd1IxVnJhR0ZWUjA0MVUycHNUVkV3Y0hkWFZtaFNZVlU1Y1ZKVVNrOWxiR3Q1VkZkd1ZrNVZNVVZSV0U1S1lsWlpNRmt3VGtwT2F6RlZWMVJPVDJGc2EzZFVWVkpPWkRBeFNVMUROVTlUTTBwQ1RteEtNbEZxVGxoV01XUkdXVlZzY0U5RlZqSmFiWEJZVDFWR05scHJjRWxaTTFaNVkzcHNlazFVVWxsV1NGSlRUMWhHV2tsdU1ITkpiV3hvWkVOSk5rMVVXVE5PYWxrelRVUmpNVTlUZDJsYVdHaDNTV3B2ZUU1cVl6Sk9hbWN4VFZSVk5XWlJMbXgyVW5oNkxVZDBjRWd4VG0xclZHOXJZMFpLT0dOMlQwWkNiRXhNZEVZME1HMUhWVXhTZVhsaUxXc2lmU3dpYVdGMElqb3hOamMyTnpFMk56QXhMQ0psZUhBaU9qRTJOelkzTXpFeE1ERjkub21hc0J3dEgyVnU4ckh4d0FJNFkzaEFILS1ISFF0UzlKSWNCNkRVODBtdyJ9LCJpYXQiOjE2NzY3MzEzMTIsImV4cCI6MTY3Njc0NTcxMn0.PIPRVka9__4Eq_9L4LxGkBEN95tusZwFrknkkcv0G4w',
                            ),
                          ),
                        );
                        ;
                      },
                    ),
                    CustomListTile(
                      title: "Messaging",
                      icon: Icons.message_outlined,
                      onTap: () {},
                    ),
                    CustomListTile(
                      title: "Calling",
                      icon: Icons.phone_outlined,
                      onTap: () {},
                    ),
                    CustomListTile(
                      title: "People",
                      icon: Icons.contacts_outlined,
                      onTap: () {},
                    ),
                    CustomListTile(
                      title: "Calendar",
                      icon: Icons.calendar_today_rounded,
                      onTap: () {},
                    ),
                  ],
                ),
                const Divider(),
                const _SingleSection(
                  children: [
                    CustomListTile(
                      title: "Help & Feedback",
                      icon: Icons.help_outline_rounded,
                      onTap: null,
                    ),
                    CustomListTile(
                      title: "About",
                      icon: Icons.info_outline_rounded,
                      onTap: null,
                    ),
                    CustomListTile(
                      title: "Sign out",
                      icon: Icons.exit_to_app_rounded,
                      onTap: null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        Column(
          children: children,
        ),
      ],
    );
  }
}
