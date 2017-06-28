$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Convert-ConsulMessage" {

    # ----- Get Function Help
    # ----- Pester to test Comment based help
    # ----- http://www.lazywinadmin.com/2016/05/using-pester-to-test-your-comment-based.html
    Context "Help" {

        $H = Help Convert-ConsulMessage -Full

        # ----- Help Tests
        It "has Synopsis Help Section" {
            $H.Synopsis | Should Not BeNullorEmpty
        }

        It "has Description Help Section" {
            $H.Description | Should Not BeNullorEmpty
        }

        It "has Parameters Help Section" {
            $H.Parameters | Should Not BeNullorEmpty
        }

        # Examples
        it "Example - Count should be greater than 0"{
            $H.examples.example.code.count | Should BeGreaterthan 0
        }
            
        # Examples - Remarks (small description that comes with the example)
        foreach ($Example in $H.examples.example)
        {
            it "Example - Remarks on $($Example.Title)"{
                $Example.remarks | Should not BeNullOrEmpty
            }
        }

        It "has Notes Help Section" {
            $H.alertSet | Should Not BeNullorEmpty
        }
    } 

    Context "Output" {

        $Message = '2017/06/28 08:11:04 [INFO] raft: Node at 192.168.0.65:8300 [Candidate] entering Candidate state in term 283415' | Convert-ConsulMessage -verbose

        It "Returns a custom object" {
            $Message | Should BeOfType PSCustomObject
        }

        It "Should have an attribute named Date of Type Date" {
            $Message.Date | Should BeOfType DateTime
        }

        It "Should have an attribute named Mesage of type String" {
            $Message.Message | Should BeOfType String
        }

        It "Should have an attribute named Type of type String" {
            $Message.Type | Should BeOfType String
        }

        It "Should have an attribute named Level of type String" {
            $Message.Type | Should BeOfType String
        }
    }
}
